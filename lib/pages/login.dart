import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grocerapp/pages/Signup.dart';
import 'package:grocerapp/pages/home.dart';
import 'package:grocerapp/pages/widgetsall/fonthelper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Future<void> signin(String email, String password) async {
    UserCredential userCredential;
    if (email == "" || password == "") {
      print("enter required fields");
    }
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    } on FirebaseAuthException catch (ex) {
      print(ex);
    }
  }

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
              Text("Welcome Back👋", style: Fonthelper.headLineTextsyle()),
              Text(
                "Signin to your account     ",
                style: Fonthelper.mediumTextstyle(
                  color: Colors.grey,
                  font: FontWeight.w900,
                ),
              ),
              SizedBox(height: 30),
              //email
              Text(
                "Email",
                style: Fonthelper.mediumTextstyle(
                  color: Colors.black,
                  font: FontWeight.w900,
                ),
              ),
              SizedBox(height: 5),
              //email textfield
              Fonthelper.customTextfield(
                email,
                "Enter your Email!",
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
              //forgetpassword
              Text(
                "Forget Password?",
                style: Fonthelper.mediumTextstyle(
                  color: Color(0xFF2F7A59),
                  font: FontWeight.w900,
                ),
              ),
              SizedBox(height: 15),
              //login button
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Fonthelper.custombutton("Login", () {
                  signin(email.text.toString(), password.text.toString());
                }),
              ),
              SizedBox(height: 10),
              //dont have an acc
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Dont have an account?",
                    style: Fonthelper.mediumTextstyle(font: FontWeight.w500),
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Signup()),
                      );
                    },

                    child: Text(
                      " Sign Up ",
                      style: Fonthelper.mediumTextstyle(
                        font: FontWeight.w500,
                        color: Color(0xFF2F7A59),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                "_______________________Or with_____________________",
                style: Fonthelper.mediumTextstyle(
                  color: Colors.grey,
                  fontsize: 16,
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Fonthelper.custombutton(
                  "Sign in With google",
                  color: Color(0xFFFAFAFA),
                  colors: Colors.black,
                  icons: FontAwesomeIcons.google,
                  () {},
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Fonthelper.custombutton(
                  "Sign in With apple",
                  color: Color(0xFFFAFAFA),
                  colors: Colors.black,
                  icons: FontAwesomeIcons.apple,
                  () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
