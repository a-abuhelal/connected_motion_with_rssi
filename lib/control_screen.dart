import 'package:connected_motion_with_rssi/buttons.dart';
import 'package:connected_motion_with_rssi/on_off_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ControlScreen extends StatelessWidget {
  const ControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        SizedBox(
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
        /*const SizedBox(
          height: 5,
        ),*/
        SizedBox(
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
                  'Errors: ',
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 25,
                    color: Colors.white,
                    height: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'No Errors',
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
          height: 25,
        ),
        const Card(
          color: Color.fromARGB(195, 139, 139, 139),
          child: ExpansionTile(
            leading: Icon(
              Icons.key_outlined,
              color: Colors.white,
            ),
            title: Text('Controls'),
            children: [
              /*ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 60),
                onTap: () {},
                title: const Text('hello'),
              ),*/
              Buttons(
                'Lock',
                Icons.lock,
              ),
              Buttons(
                'Unlock',
                Icons.lock_open,
              ),
              Buttons(
                'Panic!',
                CupertinoIcons.bell,
              ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
        /*const Buttons(
          'Lock',
          Icons.lock,
        ),*/
        /*const Buttons(
          'Unlock',
          Icons.lock_open,
        ),
        const Buttons(
          'Panic!',
          CupertinoIcons.bell,
        ),*/
        const SizedBox(
          height: 25,
        ),
        SizedBox(
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
                  'Key Power:   ',
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 25,
                    color: Colors.white,
                    height: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
                OnOffSwitch(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
