package co.fieldos.zebra_link_os

import android.content.Context
import com.zebra.sdk.printer.discovery.BluetoothDiscoverer
import com.zebra.sdk.printer.discovery.DiscoveredPrinter
import com.zebra.sdk.printer.discovery.DiscoveredPrinterBluetooth
import com.zebra.sdk.printer.discovery.DiscoveryHandler

class PrinterDiscovererBluetooth(
    private val onFound: (printer: DiscoveredPrinterBluetooth) -> Unit,
    private val onFinished: () -> Unit,
    private val onError: (error: String) -> Unit
) {
    fun findPrinters(context: Context) {
        try {
            BluetoothDiscoverer.findPrinters(context, Handler(onFound, onFinished, onError))
        } catch (e: Exception) {
            e.printStackTrace()
            onError(e.message ?: "Unknown error")
        }
    }
}

private class Handler(
    private val onFound: (printer: DiscoveredPrinterBluetooth) -> Unit,
    private val onFinished: () -> Unit,
    private val onError: (error: String) -> Unit
) : DiscoveryHandler {
    override fun foundPrinter(printer: DiscoveredPrinter) {
        if (printer is DiscoveredPrinterBluetooth) onFound(printer)
    }

    override fun discoveryFinished() = onFinished()

    override fun discoveryError(erro: String) = onError(erro)
}