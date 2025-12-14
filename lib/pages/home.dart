import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocerapp/pages/widgetsall/fonthelper.dart';

import 'dart:typed_data';

import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String track = "0";
  Uint8List? decodedBytes(String base64) {
    if (imageCache.containsKey(base64)) {
      return imageCache[base64];
    }
    try {
      final bytes = base64Decode(base64);
      imageCache[base64] = bytes;
      return bytes;
    } catch (e) {
      imageCache[base64] = null;
      print("Base64 decode error: $e");
      return null;
    }
  }

  //to solve the issue of rebuilding stream issue when we click it start geting data again
  final categoryStream = FirebaseFirestore.instance
      .collection("Foodtile")
      .snapshots();
  final Map<String, Uint8List?> imageCache = {};
  // final Productsecstream = FirebaseFirestore.instance
  //     .collection("Home")
  //     .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(left: 15.w, top: 40.h),
        child: Column(
          children: [
            // Top Row with Logo and Profile Image
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/kupatext.png",
                      height: 50.h,
                      width: 100.w,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      "order your favourite food!",
                      style: Fonthelper.mediumTextstyle(font: FontWeight.w400),
                    ),
                  ],
                ),
                Row(
                  //name hello
                  children: [
                    Text(
                      "",
                      style: Fonthelper.mediumTextstyle(fontsize: 10.sp),
                    ),

                    Container(
                      padding: EdgeInsets.only(right: 10.w),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.r),
                        child: Image.asset(
                          "assets/images/boy.png",
                          height: 60.h,
                          width: 60.w,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 25.h),
            // Search Bar
            Fonthelper.SearchBar(),
            SizedBox(height: 15.h),
            // Horizontal Category List
            Container(
              height: 55.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: StreamBuilder<QuerySnapshot>(
                stream: categoryStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {}
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("No data found"));
                  }
                  if (track == "0") {
                    final firstdocId = snapshot.data!.docs[0].id;
                    Future.microtask(() {
                      setState(() {
                        track = firstdocId;
                      });
                    });
                  }

                  // ListView.builder for categories
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final doc = snapshot.data!.docs[index];
                      final docId = doc.id;
                      final title = doc["title"] ?? "No Title";
                      final image = doc["image"] ?? "No Image";
                      return CategoryTile(title, image, docId);
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 20.0.h),
            //Stream builder Product section
            Expanded(
              child: track == "0"
                  ? Center(child: Text("NO product selected"))
                  : StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Foodtile")
                          .doc(track)
                          .collection("Products")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (track == "0") {
                          return Center(child: Text("No product selected"));
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              "Stream builder section ${snapshot.error}",
                            ),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Color.fromARGB(255, 241, 1, 1),
                            ),
                          );
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(child: Text("No data found"));
                        }
                        return GridView.builder(
                          padding: EdgeInsets.zero,

                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.85,
                                mainAxisSpacing: 10.0,
                                crossAxisSpacing: 20.0,
                              ),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, Index) {
                            final doc = snapshot.data!.docs[Index];
                            // final docId = doc.id;
                            final title = doc["title"] ?? "No title";
                            final image = doc["image"] ?? "No image";
                            final price = doc["price"] ?? "No price";
                            final discountprice =
                                doc["discount"] ?? " No price";
                            return ProductSec(
                              title,
                              price,
                              discountprice,
                              image,
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  //food tile section
  Widget CategoryTile(String name, String image, String categoryId) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        //on tap par track ki value update ho rahi hum nay just setstate update karwanay kay liye track == catergoryindex is ka use kia because ho he nahi sakta yeah alse ho because cindex ki value he track may ja rahi hy

        setState(() {
          track = categoryId;
          print("Selected track: $categoryId");
        });
      },
      child: track == categoryId
          ? Container(
              margin: EdgeInsets.only(right: 10.w),
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              height: 50.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),

                color: Color.fromARGB(255, 241, 1, 1),
              ),
              child: Row(
                children: [
                  decodedBytes(image) != null
                      ? Image.memory(
                          decodedBytes(image)!,
                          height: 40.h,
                          width: 40.h,
                          fit: BoxFit.contain,
                        )
                      : Icon(Icons.error, color: Colors.white),
                  SizedBox(width: 5.w),
                  Text(
                    name,
                    style: Fonthelper.mediumTextstyle(color: Colors.white),
                  ),
                ],
              ),
            )
          : Container(
              margin: EdgeInsets.only(right: 10.w),
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              height: 50.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: Color(0xFFececf8),
              ),
              child: Row(
                children: [
                  decodedBytes(image) != null
                      ? Image.memory(
                          decodedBytes(image)!,
                          height: 40.h,
                          width: 40.h,
                          fit: BoxFit.contain,
                        )
                      : Icon(Icons.error, color: Colors.white),
                  SizedBox(width: 5.w),
                  Text(
                    name,
                    style: Fonthelper.mediumTextstyle(color: Colors.black),
                  ),
                ],
              ),
            ),
    );
  }

  // Product Section
  Widget ProductSec(String name, String price, String dic_price, image) {
    return Container(
      // padding: EdgeInsets.only(left: 10.w, top: 10.h),
      margin: EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Color(0xFFececf8),
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.only(
          topLeft: Radius.zero,
          topRight: Radius.zero,
          bottomLeft: Radius.circular(15.0.r),
          bottomRight: Radius.circular(15.0.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3), // Rang
            blurRadius: 20, 
            offset: Offset(0, 10), 
          ),
        ],
      ),
      child: Column(
        children: [
          Center(
            child: decodedBytes(image) != null
                ? Image.memory(
                    decodedBytes(image)!,
                    height: 140.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Icon(Icons.error, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
