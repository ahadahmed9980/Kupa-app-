import 'package:flutter/material.dart';
import 'package:grocerapp/pages/login.dart';
import 'package:grocerapp/pages/widgetsall/fonthelper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _LoginState();
}

class _LoginState extends State<Signup> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
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
          ],
        ),
      ),
    );
  }
}
