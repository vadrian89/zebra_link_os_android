package co.fieldos.zebra_link_os

import android.content.Context
import android.util.Log
import com.zebra.sdk.comm.BluetoothConnection
import com.zebra.sdk.graphics.internal.ZebraImageAndroid
import com.zebra.sdk.printer.ZebraPrinterFactory
import java.lang.Thread.sleep
import java.util.concurrent.Executors
import java.util.concurrent.atomic.AtomicBoolean


class ZebraLinkOsPlugin(
    private val context: Context,
) {
    companion object {
        private var discoveryInProgress: AtomicBoolean = AtomicBoolean(false)
    }
    private var connection: BluetoothConnection? = null

    // Single background thread so that all printer operations run off the
    // Flutter platform/UI thread (which are merged since Flutter 3.29) and are
    // serialized (a BluetoothConnection is not thread-safe). The worker is a
    // daemon thread so it never keeps the process alive on its own.
    private val executor = Executors.newSingleThreadExecutor { r ->
        Thread(r, "ZebraLinkOsPlugin").apply { isDaemon = true }
    }

    private val disconnectCallbacks = object : ResultCallbacksInterface {
        override fun onSuccess(result: String) {
            Log.d("ZebraLinkOsPlugin", "Disconnected from printer internally")
        }
        override fun onError(error: String) {
            Log.e("ZebraLinkOsPlugin", "Error disconnecting from printer internally", Exception(error))
        }
    }

    fun connect(address: String, callbacks: ResultCallbacksInterface) = executor.execute {
        if (connection?.macAddress == address || connection?.isConnected == true) {
            Log.d("ZebraLinkOsPlugin", "Already connected to printer")
            callbacks.onSuccess(connection!!.macAddress)
            return@execute
        }
        try {
            connection = BluetoothConnection(address)
            connection!!.open()
            callbacks.onSuccess(connection!!.macAddress)
            Log.d("ZebraLinkOsPlugin", "Connected to printer")
        } catch (e: Exception) {
            Log.e("ZebraLinkOsPlugin", "Error connecting to printer", e)
            e.printStackTrace()
            callbacks.onError(e.message ?: "Unknown error")
        }
    }

    fun disconnect(callbacks: ResultCallbacksInterface) = executor.execute {
        try {
            if (connection?.isConnected == true) connection?.close()
            callbacks.onSuccess("")
        } catch (e: Exception) {
            Log.e("ZebraLinkOsPlugin", "Error closing connection", e)
            e.printStackTrace()
            callbacks.onError(e.message ?: "Unknown error")
        }
        connection = null
        Log.d("ZebraLinkOsPlugin", "Disconnected from printer")
    }

    fun startDiscovery(discoveryHandler: DiscoveryHandlerBluetooth) = executor.execute {
        if (discoveryInProgress.get()) {
            return@execute discoveryHandler.onError("discoveryInProgress")
        }
        discoveryInProgress.set(true)
        Log.d("ZebraLinkOsPlugin", "Starting discovery")
        val discoverer = PrinterDiscovererBluetooth(
            discoveryHandler::onFound,
            {
                if (discoveryInProgress.compareAndSet(true,false)) {
                    Log.d("ZebraLinkOsPlugin", "Discovery finished")
                } else {
                    Log.w("ZebraLinkOsPlugin", "Discovery was not in progress")
                }
                discoveryHandler.onFinished()
            },
            {
                    message ->
                discoveryHandler.onError(message)
                Log.e("ZebraLinkOsPlugin", "Discovery error: $message")

            }
        )
        try {
            discoverer.findPrinters(context)
        } catch (e: Exception) {
            discoveryInProgress.set(false)
            discoveryHandler.onError("Unknown error")
            Log.e("ZebraLinkOsPlugin", "Error finding printers", e)
            e.printStackTrace()
            disconnect(disconnectCallbacks)
        }
    }

    /// Print an image to a printer
    fun printImage(filePath: String, x: Int = 0, y: Int = 0, width: Int = 0, height: Int = 0, insideFormat: Int = 0, callbacks: ResultCallbacksInterface) = executor.execute {
        Log.d("ZebraLinkOsPlugin", "Printing: $filePath")
        try {
            val effectivePrinter = ZebraPrinterFactory.getInstance(connection)
            val image = ZebraImageAndroid(filePath)
            effectivePrinter.printImage(image, x, y, width, height, insideFormat == 1)
            sleep(500L)
            callbacks.onSuccess("")
        } catch (e: Exception) {
            Log.e("ZebraLinkOsPlugin", "Error printing image", e)
            e.printStackTrace()
            callbacks.onError(e.message ?: "Unknown error")
            disconnect(disconnectCallbacks)
        }
    }

    // Store an image in the printer's memory.
    fun storeImage(filePath: String, deviceDriveAndFileName: String, width: Int = 0, height: Int = 0, callbacks: ResultCallbacksInterface) = executor.execute {
        Log.d("ZebraLinkOsPlugin", "Storing image: $filePath as $deviceDriveAndFileName")
        try {
            val effectivePrinter = ZebraPrinterFactory.getInstance(connection)
            effectivePrinter.storeImage(deviceDriveAndFileName, filePath, width, height)
            sleep(500L)
            callbacks.onSuccess("")
        } catch (e: Exception) {
            Log.e("ZebraLinkOsPlugin", "Error storing image", e)
            e.printStackTrace()
            callbacks.onError(e.message ?: "Unknown error")
            disconnect(disconnectCallbacks)
        }
    }

    // Write the string to a printer.
    fun write(string: String, callbacks: ResultCallbacksInterface) = executor.execute {
        Log.d("ZebraLinkOsPlugin", "Printing: $string")
        try {
            connection!!.write(string.toByteArray())
            sleep(500L)
            callbacks.onSuccess("")
        } catch (e: Exception) {
            Log.e("ZebraLinkOsPlugin", "Error printing string", e)
            e.printStackTrace()
            callbacks.onError(e.message ?: "Unknown error")
            disconnect(disconnectCallbacks)
        }
    }

    // Release the background executor when the plugin is no longer needed.
    fun dispose() {
        executor.shutdown()
    }
}

