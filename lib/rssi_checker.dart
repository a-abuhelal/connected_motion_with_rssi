import 'package:flutter_reactive_ble/flutter_reactive_ble.dart' as ble;

class RssiChecker {
  Future<int> rssiGet(String id) async {
    final rssi = await ble.FlutterReactiveBle().readRssi(id);
    return rssi;
  }
}


/*void _sendRSSIValue() async {
    final deviceId = connectedDevice!.id.toString();
    final rssi = await temp.RssiChecker().rssiGet(deviceId);
    //final rssi = await ble.FlutterReactiveBle().readRssi(connectedDevice!.id.toString());
    sendData('6E400002-B5A3-F393-E0A9-E50E24DCCA9E', rssi.toString());
  }*/