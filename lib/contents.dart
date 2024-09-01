//import 'package:connected_motion_ui/bluetooth_controller.dart';
//import 'package:connected_motion_ui/bluetooth_screen.dart';
//import 'package:connected_motion_ui/bluetooth_screen2.dart';
import 'package:connected_motion_with_rssi/bluetooth_screen3.dart';
//import 'package:connected_motion_ui/buttons.dart';
//import 'package:connected_motion_ui/on_off_switch.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_blue/flutter_blue.dart';
//import 'package:get/get.dart';

class PageContent extends StatelessWidget {
  const PageContent({super.key});

  @override
  Widget build(context) {
    //final _bleController = BluetoothController();
    return const Column(
      children: [
        /*const SizedBox(
          height: 25,
        ),*/
        //1st row- we removed the row
        /*SizedBox(
          width: double.infinity,
          height: 50,
          child: Container(
            width: 240.0,
            height: 42.0,
            decoration: const BoxDecoration(
              color: Color.fromARGB(195, 78, 78, 78),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Status: ',
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 25,
                    color: Colors.white,
                    height: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Not Connected',
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 25,
                    color: Colors.white,
                    height: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),*/
        //Spacer(),
        /*const Buttons(
          'Scan',
          Icons.bluetooth,
        ),*/
        BluetoothScreen3(),
        //this expanded widget should stay !!!!!!!!!!!!!
        /*Expanded(
          child: Row(
            children: [
              //this expanded widget should stay !!!!!!!!!!!!!
              Expanded(child: BluetoothScreen2()),
              /*Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /*SizedBox(
                      height: 400,
                      child: SingleChildScrollView(
                        child: BluetoothScreen(),
                      ),
                    ),*/
                    GetBuilder<BluetoothController>(
                      init: BluetoothController(),
                      builder: (BluetoothController _bleController) {
                        return Center(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                StreamBuilder<List<ScanResult>>(
                                  stream: _bleController.scanResults,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return ListView.builder(
                                          itemBuilder: (context, index) {
                                        final data = snapshot.data![index];
                                        return Card(
                                          elevation: 2,
                                          child: Row(
                                            children: [
                                              ListTile(
                                                title: Text(data.device.name),
                                                subtitle:
                                                    Text(data.device.id.id),
                                                trailing: Text(
                                                    data.device.toString()),
                                              ),
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.blue),
                                                child: const Text(
                                                  'Connect',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                onPressed: () {},
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                    } else {
                                      return const Center(
                                        child: Text('No Devices Found'),
                                      );
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    ElevatedButton(
                      onPressed: () => _bleController.scanDevice(),
                      child: const Text("SCAN"),
                    ),
                  ],
                ),
              ),*/
            ],
          ),
        ),*/
        //second row end
        //const Spacer(),
        /*SizedBox(
          width: double.infinity,
          height: 50,
          child: Container(
            width: 240.0,
            height: 42.0,
            decoration: const BoxDecoration(
              color: Color.fromARGB(195, 78, 78, 78),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Status: ',
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 25,
                    color: Colors.white,
                    height: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Not Connected',
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 25,
                    color: Colors.white,
                    height: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),*/
        /*const SizedBox(
          height: 10,
        ),*/
      ],
    );
  }
}
