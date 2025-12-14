import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:grocerapp/pages/widgetsall/fonthelper.dart';
import 'package:image_picker/image_picker.dart';

class Addsubcollection extends StatefulWidget {
  const Addsubcollection({super.key});

  @override
  State<Addsubcollection> createState() => _AddsubcollectionState();
}

class _AddsubcollectionState extends State<Addsubcollection> {

  TextEditingController document = TextEditingController();
  TextEditingController documentsub = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController discount = TextEditingController();

  Future<void> savebase64() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      print("image picked");

      //Ye line picked object se File object banata hai.
      // File object se hum image ke bytes access kar sakte hain.
      File? file = picked != null ? File(picked.path) : null;
      if (file == null) {
        print("no image selected");
        return null;
      }
      //final file = File(picked.path);

      //file.readAsBytes() → image ke bytes read karta hai -> base64Encode(...) → bytes ko Base64 string me convert karta hai
      String base64str = base64Encode(await file.readAsBytes());
      try {
        await FirebaseFirestore.instance
            .collection("Foodtile")
            .doc(document.text)
            .collection("Products")
            .doc(documentsub.text)
            .set({
              "image": base64str,
              "price": price.text,
              "title": title.text,
              "discount": discount.text,
            }, SetOptions(merge: true));
      } catch (ex) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error! $ex"), duration: Duration(seconds: 3)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add sub Collection"), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(height: 5),
            Fonthelper.customTextfield(document, "Document", null, false, null),
            SizedBox(height: 5),
            Fonthelper.customTextfield(
              documentsub,
              "document sub",
              null,
              false,
              null,
            ),
            SizedBox(height: 5),
            Fonthelper.customTextfield(title, "Title", null, false, null),
            SizedBox(height: 5),
            Fonthelper.customTextfield(price, "Price", null, false, null),
            SizedBox(height: 5),
            Fonthelper.customTextfield(discount, "Discount", null, false, null),
            SizedBox(height: 5),
            Fonthelper.custombutton("Upload", () {
              savebase64();
            }),
          ],
        ),
      ),
    );
  }
}
