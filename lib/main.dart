import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; 
import 'package:flutter_stripe/flutter_stripe.dart'; 
import 'package:grocerapp/pages/splasescreen.dart';
import 'package:grocerapp/secret/keys.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Firebase Initialize karein
  await Firebase.initializeApp();

 
  Stripe.publishableKey =
      "pk_test_51Sh9kL3IQK3L8N1sImJBXBOTS2MpivuPc09lQqV6fVq10e6i8d3pETvqNch4k9bWuMsLk5gM8rmP3bq82IvdCuCx00LiTWfkhR"; // Apni key yahan likhein
  await Stripe.instance.applySettings();

  runApp(
   
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 914),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Grocer App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            useMaterial3: true,
          ),
          home: const Splasescreen(),
        );
      },
    );
  }
}
