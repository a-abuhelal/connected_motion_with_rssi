//this screen includes connecting and the buttons
// ignore_for_file: avoid_print, library_private_types_in_public_api

//i did change the ext.kotlin_version to '1.8.0-Beta' in build.gradle file in android folder because i had build errors after
//using the flutter_reactive_ble package
//and i changed minSdkVersion to 21 in the build.gradle file in the android/app folder

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:connected_motion_with_rssi/rssi_checker.dart' as temp;

Future<List<List<BluetoothService>>> streamToIterable(
    Stream<List<BluetoothService>> stream) async {
  final completer = Completer<List<List<BluetoothService>>>();
  final List<List<BluetoothService>> elements = [];

  await stream.forEach((element) {
    elements.add(element);
  });

  completer.complete(elements);
  return completer.future;
}

class BluetoothScreen3 extends StatefulWidget {
  const BluetoothScreen3({super.key});

  @override
  _BluetoothScreenState createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen3> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<BluetoothDevice> devices = [];
  bool isScanning = false;
  BluetoothDevice? connectedDevice;
  String errorLabel = 'Errors: No Errors';
  Timer? timer;

  void startScanning() {
    setState(() {
      devices.clear();
      isScanning = true;
      connectedDevice = null;
    });

    flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        if (!devices.contains(result.device)) {
          setState(() {
            devices.add(result.device);
          });
        }
      }
    });

    flutterBlue.startScan(timeout: const Duration(seconds: 5));
    Future.delayed(const Duration(seconds: 5), stopScanning);
  }

  void stopScanning() {
    setState(() {
      isScanning = false;
    });
    flutterBlue.stopScan();
  }

  void connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      setState(() {
        connectedDevice = device;
      });

      if (device.state == BluetoothDeviceState.connected) {
        setState(() {
          connectedDevice = device;
        });
        // Start sending RSSI value every 2 seconds
        Timer.periodic(Duration(seconds: 2), (timer) async {
          getRSSIValue();
        });
      }

      // Handle further operations after successful connection
    } catch (e) {
      print('Error connecting to ${device.name}: $e');
      setState(() {
        errorLabel = 'Error connecting to ${device.name}: $e';
      });
    }
  }

  Future<void> sendData(String targetCharacteristicUUID, String data) async {
    try {
      if (connectedDevice !=
              null /*&&
          connectedDevice!.state == BluetoothDeviceState.connected*/
          ) {
        // Discover services to ensure characteristics are available
        List<BluetoothService> services =
            await connectedDevice!.discoverServices();

        // Iterate through all available services and characteristics
        for (BluetoothService service in services) {
          for (BluetoothCharacteristic characteristic
              in service.characteristics) {
            if (characteristic.uuid == Guid(targetCharacteristicUUID)) {
              // Write data to the target characteristic
              await characteristic.write(data.codeUnits);
              print(
                  'Data sent successfully to characteristic with UUID: $targetCharacteristicUUID');
              return;
            }
          }
        }

        // If the loop completes without finding the target characteristic
        print(
            'Target characteristic with UUID $targetCharacteristicUUID not found.');
      } else {
        print('Device not connected.');
      }
    } catch (e) {
      print('Error sending data: $e');
      setState(() {
        errorLabel = 'Error sending data: \n $e';
      });
    }
  }

  void getRSSIValue() async {
    final deviceId = connectedDevice!.id.toString();
    final rssi = await temp.RssiChecker().rssiGet(deviceId);
    //final rssi = await ble.FlutterReactiveBle().readRssi(connectedDevice!.id.toString());
    sendData('6E400002-B5A3-F393-E0A9-E50E24DCCA9E', rssi.toString());
  }

// Example usage:
// sendDataToCharacteristic("your_target_characteristic_uuid", "Hello, Bluetooth!");

  /*void sendData(String data) async {
    if (connectedDevice != null) {
      try {
        // Replace the next line with the actual characteristic UUID you want to use
        String targetCharacteristicUUID =
            "6E400002-B5A3-F393-E0A9-E50E24DCCA9E";

        final myIterable = await streamToIterable(connectedDevice!.services);

        // Iterate through all available services and characteristics
        for (var servicesList in myIterable) {
          for (BluetoothService service in servicesList) {
            for (BluetoothCharacteristic characteristic
                in service.characteristics) {
              if (characteristic.uuid.toString() == targetCharacteristicUUID) {
                // Write data to the target characteristic
                characteristic.write(data.codeUnits);
                return;
              }
            }
          }
        }
        //UUID=267fb981-e636-4fe9-9252-abf89b334178
        //device=48:E7:29:36:06:42
        // If the loop completes without finding the target characteristic
        print('Target characteristic not found.');
      } catch (e) {
        print('Error sending data: $e');
      }
    } else {
      print('Not connected to any device.');
    }
  }*/

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // print('screen height : $screenHeight');
    // print('screen width : $screenWidth');

    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 0.1 * screenHeight,
                  child: Container(
                    width: screenWidth,
                    height: 0.1 * screenHeight,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (connectedDevice != null)
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Status: Connected to: ${connectedDevice!.name.isEmpty ? 'Unknown Device' : connectedDevice!.name}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          )
                        else
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Status: Not Connected',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.1 * screenHeight,
                  width: screenWidth,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 0.015 * screenHeight,
                      horizontal: 0.25 * screenWidth,
                    ),
                    child: ElevatedButton(
                      onPressed: isScanning ? null : startScanning,
                      child:
                          Text(isScanning ? 'Scanning...' : 'Scan for Devices'),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    //padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    itemCount: devices.length,
                    itemBuilder: (context, index) {
                      BluetoothDevice device = devices[index];
                      return Card(
                        elevation: 100,
                        child: ListTile(
                          title: Text(
                            device.name.isEmpty
                                ? 'Unknown Device'
                                : device.name,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                          ),
                          subtitle: Text(device.id.id),
                          onTap: () {
                            stopScanning();
                            connectToDevice(device);
                          },
                        ),
                      );
                    },
                  ),
                ),
                //const Spacer(),
                SizedBox(
                  height: 0.08 * screenHeight,
                  width: screenWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.lock),
                        onPressed: () {
                          sendData(
                              '6E400002-B5A3-F393-E0A9-E50E24DCCA9E', '25');
                        },
                        label: const Text('Lock'),
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.lock_open),
                        onPressed: () {
                          sendData(
                              '6E400002-B5A3-F393-E0A9-E50E24DCCA9E', '26');
                        },
                        label: const Text('Unlock'),
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.speaker_phone_rounded),
                        onPressed: () {
                          sendData(
                              '6E400002-B5A3-F393-E0A9-E50E24DCCA9E', '12');
                        },
                        label: const Text('Panic'),
                      ),
                    ],
                  ),
                ),
                //const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 0.12 * screenHeight,
                  child: Container(
                    width: screenWidth,
                    height: 0.12 * screenHeight,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            maxLines: null,
                            connectedDevice != null
                                ? errorLabel
                                : 'Errors: No connected Device',
                            textAlign: TextAlign.center,
                            softWrap: true,
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    stopScanning();
    timer?.cancel();
    super.dispose();
  }
}
