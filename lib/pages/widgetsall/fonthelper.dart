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

  static custombutton(String text, VoidCallback callback, {Color? color}) {
    return Container(
      width: 300,
      height: 70,
      padding: EdgeInsetsGeometry.symmetric(horizontal: 5, vertical: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Color(0xFF2F7A59),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 7,
          shadowColor: Colors.black
        ),
        onPressed: callback,
        child: Text(
          "$text",
          style: Fonthelper.mediumTextstyle(color: Colors.white),
        ),
      ),
    );
  }
  // static scrolling ()
}
