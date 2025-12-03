import 'package:flutter/material.dart';

class Fonthelper {
  static TextStyle headLineTextsyle({Color? color}) {
    return TextStyle(
      color: color ?? Colors.black,
      fontSize: 28,
      fontWeight: FontWeight.w800,
    );
  }

  static TextStyle mediumTextstyle({Color? color}) {
    return TextStyle(
      color: color ?? Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    );
  }

  static custombutton(String text, VoidCallback callback) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
      onPressed: callback,
      child: Text(
        "$text",
        style: Fonthelper.mediumTextstyle(color: Colors.white),
      ),
    );
  }
}
