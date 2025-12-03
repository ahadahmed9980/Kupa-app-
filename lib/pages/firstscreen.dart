import 'package:flutter/material.dart';
import 'package:grocerapp/pages/widgetsall/fonthelper.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kupa",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                height: 400,
                width: 400,

                child: Image.asset("assets/images/main.png"),
              ),

              Text("All your", style: Fonthelper.headLineTextsyle()),
              Text("favourites foods ", style: Fonthelper.headLineTextsyle()),
              Text(
                "Order your favourite food with ",
                style: Fonthelper.mediumTextstyle(color: Colors.grey),
              ),
              Text(
                " quick delivery ",
                style: Fonthelper.mediumTextstyle(color: Colors.grey),
              ),
              Container(
                width: 300,
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 25,
                  vertical: 10,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {},
                  child: Text(
                    "Continue",
                    style: Fonthelper.mediumTextstyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
