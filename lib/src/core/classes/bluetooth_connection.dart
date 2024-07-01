import 'package:zebra_link_os_android/core.dart';

abstract class BluetoothConnection implements Disposable {
  final String address;

  BluetoothConnection({required this.address});

  void close();

  void open();

  void writeTest();
}