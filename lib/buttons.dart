import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  const Buttons(this.text, this.icon, {super.key});

  //final Function() onTap;

  final IconData icon;
  final String text;

  @override
  Widget build(context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        fixedSize: const Size(200, 40),
      ),
      label: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}
