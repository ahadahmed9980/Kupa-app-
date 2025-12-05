import 'package:flutter/material.dart';

class Fonthelper {
  static TextStyle headLineTextsyle({
    FontWeight? fonts,
    Color? color,
    double? fontsize,
  }) {
    return TextStyle(
      color: color ?? Colors.black,
      fontSize: fontsize ?? 28,
      fontWeight: fonts ?? FontWeight.w800,
    );
  }

  static TextStyle mediumTextstyle({
    FontWeight? font,
    Color? color,
    double? fontsize,
  }) {
    return TextStyle(
      color: color ?? Colors.black,
      fontSize: fontsize ?? 18,
      fontWeight: font ?? FontWeight.w600,
    );
  }

  static custombutton(
  String text,
  VoidCallback callback, {
  Color? color,
  Color? colors,
  IconData? icons,
}) {
  return Container(
    width: 320,
    height: 70,
    padding: EdgeInsets.symmetric(horizontal: 1, vertical: 8),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Color(0xFF2F7A59),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 7,
        shadowColor: Colors.black,
      ),
      onPressed: callback,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
//Agar icon mila → icon dikhado Agar icon null ho → icon ko skip kardena
          if (icons != null)... [
            Icon(
              icons,
              color: colors ?? Colors.white, size: 20,
            ),
            SizedBox(width: 10),
          ],
          Text(
            text,
            style: Fonthelper.mediumTextstyle(
              color: colors ?? Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}


  static customTextfield(
    TextEditingController controller,
    String text,
    IconData? icondata,
    // IconData icons,
    bool tohide,
    VoidCallback ontap,
  ) {
    return Container(
      width: 400,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),

      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 2,
        shadowColor: Colors.black,

        child: TextField(
          obscureText: tohide,
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          cursorColor: Colors.black,
          cursorWidth: 2,
          cursorHeight: 30,
          style: Fonthelper.mediumTextstyle(font: FontWeight.w800),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              left: 10,
              right: 1,
              top: 15,
              bottom: 20,
            ),

            filled: true,
            fillColor: Color(0xFFFAFAFA),

            hintText: "${text}",
            hintStyle: Fonthelper.mediumTextstyle(
              fontsize: 16,
              color: Colors.grey,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey, width: 3),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey, width: 3),
            ),
            // suffixIcon: Icon(Icons.email, color: Colors.black, size: 25),
            suffixIcon: icondata != null
                ? Icon(icondata, color: Colors.black)
                : IconButton(
                    onPressed: ontap,
                    icon: Icon(
                      tohide ? Icons.visibility_off : Icons.visibility,
                      color: Colors.black,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
