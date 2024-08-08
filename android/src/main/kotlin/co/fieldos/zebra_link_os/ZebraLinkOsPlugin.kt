package co.fieldos.zebra_link_os

import android.content.Context
import android.util.Log
import com.zebra.sdk.comm.BluetoothConnection
import com.zebra.sdk.graphics.internal.ZebraImageAndroid
import com.zebra.sdk.printer.ZebraPrinterFactory
import com.zebra.sdk.printer.discovery.DiscoveredPrinterBluetooth
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch


class ZebraLinkOsPlugin(
    private val context: Context,
    private val discoveryHandler: DiscoveryHandlerBluetooth
) {
    private lateinit var discoverer: PrinterDiscovererBluetooth
    private val printers: MutableList<DiscoveredPrinterBluetooth> = mutableListOf()
    private var connection: BluetoothConnection? = null
    private val mainScope = CoroutineScope(Dispatchers.Main)

    private fun initDiscoverer() {
        discoverer = PrinterDiscovererBluetooth(
            ::onFound,
            discoveryHandler::onFinished,
            discoveryHandler::onError
        )
    }

    private fun maybeConnect(address: String) {
        if (connection?.macAddress == address) return
        if (connection?.isConnected == true) connection!!.close()
        connection = BluetoothConnection(address)
        connection!!.open()
    }

    fun disconnect(callbacks: ResultCallbacksInterface?) {
        try {
            connection?.close()
            callbacks?.onSuccess("")
        } catch (e: Exception) {
            Log.e("ZebraLinkOsPlugin", "Error closing connection", e)
            e.printStackTrace()
            callbacks?.onError(e.message ?: "Unknown error")
        }
        connection = null
    }

    fun findPrinters() {
        try {
            if (!this::discoverer.isInitialized) initDiscoverer()
            printers.clear()
            discoverer.findPrinters(context)
        } catch (e: Exception) {
            discoveryHandler.onError(e.message ?: "Unknown error")
            Log.e("ZebraLinkOsPlugin", "Error finding printers", e)
            e.printStackTrace()
            disconnect(null)
        }
    }

    /// Print an image to a printer
    fun printImage(address: String, filePath: String, x: Int = 0, y: Int = 0, width: Int = 0, height: Int = 0, insideFormat: Int = 0, callbacks: ResultCallbacksInterface) {
        maybeConnect(address)
        printImage(filePath, x, y, width, height, insideFormat == 1, callbacks)
    }

    // Write the string to a printer.
    //
    // The string should contain either ZPL or CPL commands.
    // The address should be the bluetooth/MAC address of the printer.
    fun writeString(address: String, string: String, callbacks: ResultCallbacksInterface) {
        maybeConnect(address)
        write(string, callbacks)
    }

    private fun printImage(filePath: String, x: Int = 0, y: Int = 0, width: Int = 0, height: Int = 0, insideFormat: Boolean = false, callbacks: ResultCallbacksInterface) {
        mainScope.launch(Dispatchers.Default) {
            Log.d("ZebraLinkOsPlugin", "Printing: $filePath")
            try {
                val effectivePrinter = ZebraPrinterFactory.getInstance(connection)
                val image = ZebraImageAndroid(filePath)
                effectivePrinter.printImage(image, x, y, width, height, insideFormat)
                delay(500L)
                callbacks.onSuccess("")
            } catch (e: Exception) {
                Log.e("ZebraLinkOsPlugin", "Error printing image", e)
                e.printStackTrace()
                callbacks.onError(e.message ?: "Unknown error")
                disconnect(null)
            }
        }
    }

    private fun write(string: String, callbacks: ResultCallbacksInterface)  {
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
                disconnect(null)
            }
        }
    }

    private fun onFound(printer: DiscoveredPrinterBluetooth) {
        printers.add(printer)
        discoveryHandler.onFound(printer)
    }
}

