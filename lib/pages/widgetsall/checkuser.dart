import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grocerapp/main.dart';
import 'package:grocerapp/pages/Signup.dart';
import 'package:grocerapp/pages/home.dart';
import 'package:grocerapp/pages/login.dart';
import 'package:grocerapp/pages/splasescreen.dart';

class Checkuser extends StatelessWidget {

  const Checkuser({super.key});


  @override
  Widget build(BuildContext context) {

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text("Kuch Ghalat Hogaya"));
        }
        final user = snapshot.data;
        if (user != null) {
          // User logged in hai
          return const Home();
        } else {
          // User logged out hai
          return const Signup();
        }
      },
    );
  }
}
