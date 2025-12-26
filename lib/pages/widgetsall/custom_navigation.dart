import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:grocerapp/pages/cart.dart';
import 'package:grocerapp/pages/home.dart';
import 'package:grocerapp/pages/orderpage.dart';
import 'package:grocerapp/pages/profilepage.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.home, size: 30, color: Colors.white),
      Icon(Icons.shopping_cart, size: 30, color: Colors.white),
      Icon(Icons.shopping_bag, size: 30, color: Colors.white),
      Icon(Icons.person, size: 30, color: Colors.white),
    ];

    return CurvedNavigationBar(
      index: currentIndex,
      items: items,
      height: 65,
      color: Color(0xFF9F0F0F),
      backgroundColor: Colors.transparent,
      animationDuration: Duration(milliseconds: 700),
      //index= taped icon
      //current index=currently selected icon 
      onTap: (indexs) {
        if (indexs == currentIndex) 
        return ;
        

        setState(() {
          currentIndex = indexs;
        });

        // page navigation
        if (indexs == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => Home()),
          );
        } else if (indexs == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => Cart()),
          );
        } else if (indexs == 2) {
           Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => Orderpage()),
          );
        }
         else if (indexs == 3) {
           Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => Profilepage()),
          );
        }
      },
    );
  }
}
