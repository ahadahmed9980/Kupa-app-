import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocerapp/pages/model/category_model.dart';
import 'package:grocerapp/pages/widgetsall/fonthelper.dart';
import 'package:grocerapp/pages/widgetsall/category.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Categorymodel> catergories = [];
  @override
  void initState() {
    catergories = getcategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(left: 20, top: 40),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/kupatext.png",
                      height: 50,
                      width: 100,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      "order your favourite food!",
                      style: Fonthelper.mediumTextstyle(font: FontWeight.w400),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      "assets/images/boy.png",
                      height: 80,
                      width: 80,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Fonthelper.SearchBar(),
            SizedBox(height: 20),
            Container(
              height: 60,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: catergories.length,
                itemBuilder: (context, Index) {
                  return Categorytile(
                    image: catergories[Index].image!,
                    name: catergories[Index].name!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Categorytile extends StatefulWidget {
  String name, image;

  Categorytile({required this.image, required this.name});

  @override
  State<Categorytile> createState() => _CategorytileState();
}

class _CategorytileState extends State<Categorytile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20.0),
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      height: 70,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
      color: const Color.fromARGB(255, 241, 1, 1)
      ),

      child: Row(
        children: [
          Image.asset(widget.image, height: 50, width: 50, fit: BoxFit.contain),
          SizedBox(width: 6),
          Text(
            widget.name,
            style: Fonthelper.mediumTextstyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
