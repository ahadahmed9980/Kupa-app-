import 'package:flutter/material.dart';
import 'package:grocerapp/pages/home.dart';
import 'package:grocerapp/pages/login.dart';
import 'package:grocerapp/pages/widgetsall/fonthelper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});
  @override
  State<Signup> createState() => _LoginState();
}

class _LoginState extends State<Signup> {
  Future<void> Signupuser() async {
    final username = name.text.trim();
    final useremail = email.text.trim();
    final userpassword = password.text.trim();
    if (username.isEmpty || useremail.isEmpty || userpassword.isEmpty) {
      print("fill all fields");
      return;
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: useremail,
              password: userpassword,
            );
        String uid = userCredential.user!.uid;
        await FirebaseFirestore.instance.collection("User").doc(uid).set({
          "uid": uid,
          "Email": useremail,
          "Name": username,
          "Password": userpassword,
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
        print("user inserted ");
      } on FirebaseAuthException catch (ex) {
        print(ex);
      }
    }
  }

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool hideEmail = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 18, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Sign Up🙋", style: Fonthelper.headLineTextsyle()),
              Text(
                "Create new account and order food you love     ",
                style: Fonthelper.mediumTextstyle(
                  color: Colors.grey,
                  font: FontWeight.w900,
                ),
              ),
              SizedBox(height: 30),
              //email
              Text(
                "Name",
                style: Fonthelper.mediumTextstyle(
                  color: Colors.black,
                  font: FontWeight.w900,
                ),
              ),
              SizedBox(height: 5),
              //email textfield
              Fonthelper.customTextfield(
                name,
                "Enter your Name!",
                FontAwesomeIcons.user,
                false,
                () {},
              ),
              SizedBox(height: 20),
              //password
              Text(
                "Email",
                style: Fonthelper.mediumTextstyle(
                  color: Colors.black,
                  font: FontWeight.w900,
                ),
              ),
              //password textfield
              Fonthelper.customTextfield(
                email,
                "Enter your email",
                Icons.email,
                false,
                () {},
              ),
              SizedBox(height: 20),
              //password
              Text(
                "Password",
                style: Fonthelper.mediumTextstyle(
                  color: Colors.black,
                  font: FontWeight.w900,
                ),
              ),
              //password textfield
              Fonthelper.customTextfield(
                password,
                "Enter your Password",
                null,
                hideEmail,
                () {
                  setState(() {
                    hideEmail = !hideEmail;
                  });
                },
              ),

              SizedBox(height: 15),
              //Register button
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Fonthelper.custombutton("Register", () {
                  Signupuser();
                }),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Alrady have an account",
                    style: Fonthelper.mediumTextstyle(font: FontWeight.w500),
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    child: Text(
                      " Login",
                      style: Fonthelper.mediumTextstyle(
                        font: FontWeight.w500,
                        color: Color(0xFF2F7A59),
                      ),
                    ),
                  ),
                ],
              ),
              //policy and privacy
              SizedBox(height: 150),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      "By clicking Register you,agree with our ",
                      style: Fonthelper.mediumTextstyle(
                        fontsize: 15,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "Terms Privacy & Policy",
                      style: Fonthelper.mediumTextstyle(
                        color: Color(0xFF2F7A59),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
