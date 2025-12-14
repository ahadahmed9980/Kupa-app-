import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocerapp/pages/firstscreen.dart';

class Splasescreen extends StatefulWidget {
  const Splasescreen({super.key});

  @override
  State<Splasescreen> createState() => _SplasescreenState();
}

class _SplasescreenState extends State<Splasescreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Loginscreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9F0F0F),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/splashlogo.png",
                height: 270.h,
                width: 270.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
