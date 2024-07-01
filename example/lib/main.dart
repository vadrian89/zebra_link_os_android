import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zebra_link_os_android/core.dart';
import 'package:zebra_link_os_android/zebra_link_os_android.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final ZebraLinkOs _plugin = ZebraLinkOs();
  late final Future<bool> _requestPermissions;
  late final StreamSubscription<DiscoveredPrinter> _subscription;
  late final ValueNotifier<Set<DiscoveredPrinter>> _printersNotifier;
  DiscoveredPrinter? _selectedPrinter;

  @override
  void initState() {
    super.initState();
    _requestPermissions = _plugin.requestPermissions();
    _subscription = _plugin.printerFound.listen(
      (event) => _printersNotifier.value = {..._printersNotifier.value, event},
    );
    _printersNotifier = ValueNotifier(const {});
  }

  @override
  void dispose() {
    _subscription.cancel();
    _plugin.dispose();
    _printersNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: FutureBuilder(
            future: _requestPermissions,
            builder: (context, snapshot) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Plugin example app"),
                ),
                body: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        switch (snapshot.connectionState) {
                          ConnectionState.done =>
                            snapshot.data == true ? "Permissions granted" : "Permissions denied",
                          _ => "Requesting permissions...",
                        },
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 16),
                      ValueListenableBuilder(
                        valueListenable: _printersNotifier,
                        builder: (context, printers, child) => ListView.builder(
                          shrinkWrap: true,
                          itemCount: printers.length,
                          itemBuilder: (context, index) {
                            final printer = printers.elementAt(index) as DiscoveredPrinterBluetooth;
                            return RadioListTile(
                              groupValue: _selectedPrinter,
                              value: printer,
                              title: Text(printer.friendlyName),
                              onChanged: (value) => setState(() => _selectedPrinter = value),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                bottomNavigationBar: ButtonBar(
                  alignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: switch (snapshot.connectionState) {
                        ConnectionState.done =>
                          (snapshot.data == true) && (_selectedPrinter != null) ? _printTest : null,
                        _ => null,
                      },
                      child: const Text("Print"),
                    ),
                    ElevatedButton(
                      onPressed: switch (snapshot.connectionState) {
                        ConnectionState.done => snapshot.data == true ? _findPrinters : null,
                        _ => null,
                      },
                      child: const Text("Find printers"),
                    ),
                  ],
                ),
              );
            }),
      );

  void _printTest() {
    var string = "! 0 200 200 210 1\r\n";
    string += "TEXT 4 0 30 40 Ola Field OS!!1\r\n";
    string += "PRINT\r\n";
    _plugin.write(string: string, printer: _selectedPrinter!);
  }

  void _findPrinters() {
    _printersNotifier.value = const {};
    _plugin.findPrinters();
  }
}
