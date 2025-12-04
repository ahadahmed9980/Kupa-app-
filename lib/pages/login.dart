import 'package:flutter/material.dart';
import 'package:grocerapp/pages/Signup.dart';
import 'package:grocerapp/pages/widgetsall/fonthelper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  bool hideEmail = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white),
      body: Container(
        margin: EdgeInsets.only(left: 18),
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
              email,
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
              child: Fonthelper.custombutton("Login", () {}),
            ),
             SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Dont have an account?",
                  style: Fonthelper.mediumTextstyle(font: FontWeight.w500),
                ),

                InkWell(
                  onTap: (){
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
          ],
        ),
      ),
    );
  }
}
