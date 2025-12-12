import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocerapp/pages/widgetsall/fonthelper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Threesteps extends StatefulWidget {
  Threesteps({super.key});

  @override
  State<Threesteps> createState() => _ThreestepsState();
}

class _ThreestepsState extends State<Threesteps> {
  TextEditingController collection = TextEditingController();
  TextEditingController document = TextEditingController();

  Future<void> saveBase64() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      print("image picked");
    }
    // picked ke andar sirf image ka path (location) hota hai, image khud nahi hoti.
    File? file = picked != null ? File(picked.path) : null;

    // Agar file null ho to Base64 convert na karein
    if (file == null) {
      print("No image selected");
      return; // yahan se function safe exit kar jaye
    }

    // Safe Base64 conversion
    String base64str = base64Encode(await file.readAsBytes());

    // Check Firestore size limit
    double sizekb = base64str.length / 1024;
    if (sizekb > 950) {
      print("File is to large");
      return;
    }
    //if size is OK then store data in to firebase;
    try {
      print("storing in to db....");
      await FirebaseFirestore.instance
          .collection(collection.text.toString())
          .doc(document.text.toString())
          .update({
            "image": base64str,
            "size_kb": sizekb.toStringAsFixed(2),
          });
    } catch (ex) {
      print("the error is $ex");
    }
  }

  // picked ke andar sirf image ka path (location) hota hai, image khud nahi hoti.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
         Fonthelper.customTextfield(collection,
                "Enter Collection",
                Icons.email,
                false,
                () {},),
          SizedBox(height: 20),
          Fonthelper.customTextfield(document, "document", Icons.add_ic_call_outlined, false, (){}),
          
          SizedBox(height: 20),
         Fonthelper.custombutton("Upload", (){
          saveBase64();
         })
        ],
      ),
    );
  }
  
}
