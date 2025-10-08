package co.fieldos.zebra_link_os

import android.content.Context
import android.util.Log
import com.zebra.sdk.comm.BluetoothConnection
import com.zebra.sdk.graphics.internal.ZebraImageAndroid
import com.zebra.sdk.printer.ZebraPrinterFactory
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch


class ZebraLinkOsPlugin(
    private val context: Context,
) {
    private var connection: BluetoothConnection? = null
    private val mainScope = CoroutineScope(Dispatchers.Main)
    private val disconnectCallbacks = object : ResultCallbacksInterface {
        override fun onSuccess(result: String) {
            Log.d("ZebraLinkOsPlugin", "Disconnected from printer internally")
        }
        override fun onError(error: String) {
            Log.e("ZebraLinkOsPlugin", "Error disconnecting from printer internally", Exception(error))
        }
    }

    fun connect(address: String, callbacks: ResultCallbacksInterface) {
        if (connection?.macAddress == address || connection?.isConnected == true) {
            Log.d("ZebraLinkOsPlugin", "Already connected to printer")
            callbacks.onSuccess(connection!!.macAddress)
            return
        }
        mainScope.launch {
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
    }

    fun disconnect(callbacks: ResultCallbacksInterface) {
        mainScope.launch(Dispatchers.Default) {
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
    }

    fun startDiscovery(discoveryHandler: DiscoveryHandlerBluetooth) {
        mainScope.launch(Dispatchers.Default) {
            val discoverer = PrinterDiscovererBluetooth(
                discoveryHandler::onFound,
                discoveryHandler::onFinished,
                discoveryHandler::onError
            )
            try {
                discoverer.findPrinters(context)
            } catch (e: Exception) {
                discoveryHandler.onError("Unknown error")
                Log.e("ZebraLinkOsPlugin", "Error finding printers", e)
                e.printStackTrace()
                disconnect(disconnectCallbacks)
            }
        }
    }

    /// Print an image to a printer
    fun printImage(filePath: String, x: Int = 0, y: Int = 0, width: Int = 0, height: Int = 0, insideFormat: Int = 0, callbacks: ResultCallbacksInterface) {
        mainScope.launch(Dispatchers.Default) {
            Log.d("ZebraLinkOsPlugin", "Printing: $filePath")
            try {
                val effectivePrinter = ZebraPrinterFactory.getInstance(connection)
                val image = ZebraImageAndroid(filePath)
                effectivePrinter.printImage(image, x, y, width, height, insideFormat == 1)
                delay(500L)
                callbacks.onSuccess("")
            } catch (e: Exception) {
                Log.e("ZebraLinkOsPlugin", "Error printing image", e)
                e.printStackTrace()
                callbacks.onError(e.message ?: "Unknown error")
                disconnect(disconnectCallbacks)
            }
        }
    }

    // Store an image in the printer's memory.
    fun storeImage(filePath: String, deviceDriveAndFileName: String, width: Int = 0, height: Int = 0, callbacks: ResultCallbacksInterface) {
        mainScope.launch(Dispatchers.Default) {
            Log.d("ZebraLinkOsPlugin", "Storing image: $filePath as $deviceDriveAndFileName")
            try {
                val effectivePrinter = ZebraPrinterFactory.getInstance(connection)
                effectivePrinter.storeImage(deviceDriveAndFileName, filePath, width, height)
                delay(500L)
                callbacks.onSuccess("")
            } catch (e: Exception) {
                Log.e("ZebraLinkOsPlugin", "Error storing image", e)
                e.printStackTrace()
                callbacks.onError(e.message ?: "Unknown error")
                disconnect(disconnectCallbacks)
            }
        }
    }

    // Write the string to a printer.
    fun write(string: String, callbacks: ResultCallbacksInterface) {
        mainScope.launch(Dispatchers.Default) {
            Log.d("ZebraLinkOsPlugin", "Printing: $string")
            try {
                connection!!.write(string.toByteArray())
                delay(500L)
                callbacks.onSuccess("")
            } catch (e: Exception) {
                Log.e("ZebraLinkOsPlugin", "Error printing string", e)
                e.printStackTrace()
                callbacks.onError(e.message ?: "Unknown error")
                disconnect(disconnectCallbacks)
            }
        }
    }
}

