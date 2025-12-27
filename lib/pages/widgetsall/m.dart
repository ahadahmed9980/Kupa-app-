import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:grocerapp/pages/home.dart';
import 'package:grocerapp/pages/cart.dart';
import 'package:grocerapp/pages/orderpage.dart';
import 'package:grocerapp/pages/profilepage.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

 
  final List<Widget> pages = [
    const Home(),
    const Cart(),
    const Orderpage(),
    const Profilepage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, 
      body: pages[currentIndex],
      
      bottomNavigationBar: CurvedNavigationBar(
        index: currentIndex,
        items: const [
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.shopping_cart, size: 30, color: Colors.white),
          Icon(Icons.shopping_bag, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
        height: 65,
        color: const Color(0xFF9F0F0F),
        backgroundColor: Colors.transparent,
        animationDuration: const Duration(milliseconds: 500),
        onTap: (index) {
          setState(() {
            currentIndex = index; 
          });
        },
      ),
    );
  }
}