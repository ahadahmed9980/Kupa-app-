import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:grocerapp/pages/Signup.dart';

import 'package:grocerapp/pages/widgetsall/addimage.dart';
import 'package:grocerapp/pages/widgetsall/fonthelper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocerapp/pages/widgetsall/m.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Future<void> signin(String email, String password) async {
    UserCredential userCredential;
    if (email == "" || password == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xFF9F0F0F),
          content: Center(
            child: Text(
              "Enter Your email & password",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    }
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } on FirebaseAuthException catch (ex) {
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xFF9F0F0F),
          content: Text(
            "$ex",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
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
          margin: EdgeInsets.only(left: 18.w, top: 10.h),
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
              SizedBox(height: 30.h),
              //email
              Text(
                "Email",
                style: Fonthelper.mediumTextstyle(
                  color: Colors.black,
                  font: FontWeight.w900,
                ),
              ),
              SizedBox(height: 5.h),
              //email textfield
              Fonthelper.customTextfield(
                email,
                "Enter your Email!",
                Icons.email,
                false,
                () {},
              ),
              SizedBox(height: 20.h),
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
              SizedBox(height: 15.h),
              //forgetpassword
              Text(
                "Forget Password?",
                style: Fonthelper.mediumTextstyle(
                  color: Color(0xFF9F0F0F),
                  font: FontWeight.w900,
                ),
              ),
              SizedBox(height: 15.h),
              //login button
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Fonthelper.custombutton("Login", () {
                  signin(email.text.toString(), password.text.toString());
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => Home()),
                  // );
                }),
              ),
              SizedBox(height: 10.h),
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
                        color: Color(0xFF9F0F0F),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Container(
                width: double.infinity,
                child: Center(
                  child: Text(
                    "________________Or with________________",
                    style: Fonthelper.mediumTextstyle(
                      color: Colors.grey,
                      fontsize: 16.sp,
                    ),
                    maxLines: 1,
                  ),
                ),
              ),
              SizedBox(height: 15.h),
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
              SizedBox(height: 10.h),
              Container(
                width: double.infinity.w,
                alignment: Alignment.center,
                child: Fonthelper.custombutton(
                  "Sign in With apple",
                  color: Color(0xFFFAFAFA),
                  colors: Colors.black,
                  icons: FontAwesomeIcons.apple,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Threesteps()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
