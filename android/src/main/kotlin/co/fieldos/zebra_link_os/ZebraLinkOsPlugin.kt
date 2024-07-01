package co.fieldos.zebra_link_os

import android.content.Context
import android.util.Log
import com.zebra.sdk.printer.ZebraPrinterFactory
import com.zebra.sdk.printer.discovery.DiscoveredPrinterBluetooth
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking


class ZebraLinkOsPlugin(
    private val context: Context,
    private val discoveryHandler: DiscoveryHandlerBluetooth
) {
    private lateinit var discoverer: PrinterDiscovererBluetooth
    private val printers: MutableList<DiscoveredPrinterBluetooth> = mutableListOf()

    private fun initDiscoverer() {
        discoverer = PrinterDiscovererBluetooth(
            ::onFound,
            discoveryHandler::onFinished,
            discoveryHandler::onError
        )
    }

    private fun printerFromAddress(address: String) = printers.find { printer -> printer.address == address }

    fun findPrinters() {
        try {
            if (!this::discoverer.isInitialized) initDiscoverer()
            printers.clear()
            discoverer.findPrinters(context)
        } catch (e: Exception) {
            discoveryHandler.onError(e.message ?: "Unknown error")
            e.printStackTrace()
        }
    }

    /// Print an image to a printer
    fun printImage(address: String, filePath: String, x: Int?, y: Int?, width: Int?, height: Int?) {
        val printer = printerFromAddress(address)
        if (printer == null) {
            Log.w("ZebraLinkOsPlugin", "Printer, with address: $address, not found")
            return
        }

    }

    private fun printImage(printer: DiscoveredPrinterBluetooth, filePath: String, x: Int?, y: Int?, width: Int, height: Int) = runBlocking {
        launch {
            Log.d("ZebraLinkOsPlugin", "Printing: $filePath")
            val connection = printer.connection
            try {
                connection.open()
                val effectivePrinter = ZebraPrinterFactory.getInstance(connection)
                effectivePrinter.printImage(filePath, x ?: 0, y ?: 0, width, height, false)
                delay(500L)
            } catch (e: Exception) {
                e.printStackTrace()
            }
            connection.close()
        }
    }

    // Write the string to a printer.
    //
    // The string should contain either ZPL or CPL commands.
    // The address should be the bluetooth/MAC address of the printer.
    fun writeString(address: String, string: String) {
        val printer = printerFromAddress(address)
        if (printer == null) {
            Log.w("ZebraLinkOsPlugin", "Printer, with address: $address, not found")
            return
        }
        Log.w("ZebraLinkOsPlugin", "Printing to $printer")
        write(printer, string)
    }

    private fun write(printer: DiscoveredPrinterBluetooth, string: String ) = runBlocking {
        launch {
            Log.d("ZebraLinkOsPlugin", "Printing: $string")
            val connection = printer.connection
            try {
                connection.open()
                connection.write(string.toByteArray())
                delay(500L)
            } catch (e: Exception) {
                e.printStackTrace()
            }
            connection.close()
        }
    }



    private fun onFound(printer: DiscoveredPrinterBluetooth) {
        printers.add(printer)
        discoveryHandler.onFound(printer)
    }
}

