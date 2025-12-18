import 'package:flutter/material.dart';
import 'package:grocerapp/pages/login.dart';
import 'package:grocerapp/pages/widgetsall/fonthelper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:grocerapp/pages/Signup.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final myitems = [
    Image.asset("assets/images/bowl.png", fit: BoxFit.contain),
    Image.asset("assets/images/bowl2.png", fit: BoxFit.contain),
    Image.asset("assets/images/frontpic.png", fit: BoxFit.contain),
  ];
  int mycurrentindes = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //appbar
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 35,
              width: 30,
              child: Image.asset("assets/images/bowl.png"),
            ),
            Text(
              "Kupa",
              style: Fonthelper.headLineTextsyle(
                fontsize: 30,
                color: Colors.black,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05,
                ),
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 0),

                //image scroll
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CarouselSlider(
                        items: myitems,
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height * 0.30,
                          autoPlay: true,

                          autoPlayAnimationDuration: Duration(seconds: 2),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          viewportFraction: 0.8, // thoda space left/right me
                          enlargeCenterPage: true,
                        ),
                      ),
                    ],
                  ),
                ),
                // Image.asset("assets/images/front.png")
              ),

              Text("All your", style: Fonthelper.headLineTextsyle()),
              Text("favourite food ", style: Fonthelper.headLineTextsyle()),

              Text(
                "Order your favourite food with ",
                style: Fonthelper.mediumTextstyle(color: Colors.grey),
              ),
              Text(
                " quick delivery ",
                style: Fonthelper.mediumTextstyle(color: Colors.grey),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Fonthelper.custombutton("Continue", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Signup()),
                );
              }),
              Fonthelper.custombutton("Sign in", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              }, color: Colors.grey),
            ],
          ),
        ],
      ),
    );
  }
}
