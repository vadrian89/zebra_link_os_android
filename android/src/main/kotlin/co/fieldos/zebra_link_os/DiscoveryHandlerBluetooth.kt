package co.fieldos.zebra_link_os

import com.zebra.sdk.printer.discovery.DiscoveredPrinterBluetooth

interface DiscoveryHandlerBluetooth {
    fun onFound(printer: DiscoveredPrinterBluetooth);
    fun onFinished();
    fun onError(error: String)
}