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
    if (base64 == null) return null;
    if (imageCache.containsKey(base64)) {
      return imageCache[base64];
    }
    try {
      final bytes = base64Decode(base64);
      imageCache[base64] = bytes;
      return base64Decode(base64);
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
  final Productsecstream = FirebaseFirestore.instance
      .collection("Home")
      .snapshots();

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

                  // ListView.builder for categories
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final doc = snapshot.data!.docs[index];
                      final title = doc["title"] ?? "No Title";
                      final image = doc["image"] ?? "No Image";
                      return CategoryTile(title, image, index.toString());
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 20.0.h),
            //Stream builder Product section
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 15.0.w),
                child: StreamBuilder(
                  stream: Productsecstream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Stream builder section ${snapshot.error}"),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
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

                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 20.0,
                      ),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, Index) {
                        final doc = snapshot.data!.docs[Index];
                        final title = doc["title"] ?? "No title";
                        final image = doc["image"] ?? "No image";
                        final price = doc["Price"] ?? "No price";
                        final discountprice = doc["DisPrice"] ?? " No price";
                        return ProductSec(title, image, price, discountprice);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //food tile section
  Widget CategoryTile(String name, String image, String catergoryindex) {
    return InkWell(
      onTap: () {
        //on tap par track ki value update ho rahi hum nay just setstate update karwanay kay liye track == catergoryindex is ka use kia because ho he nahi sakta yeah alse ho because cindex ki value he track may ja rahi hy
        track = catergoryindex.toString();
        setState(() {});
      },
      child: track == catergoryindex
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
  Widget ProductSec(String name, String image, String price, String dic_price) {
    return Container(
      padding: EdgeInsets.only(left: 10.w, top: 10.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        children: [
          Center(
            child: decodedBytes(image) != null
                ? Image.memory(
                    decodedBytes(image)!,
                    height: 100.h,
                    width: 100.h,
                  )
                : Icon(Icons.error, color: Colors.white),
          ),
          Text(
            "$name",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Fonthelper.mediumTextstyle(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("$price", style: Fonthelper.headLineTextsyle()),
              SizedBox(width: 30.w),
            ],
          ),
        ],
      ),
    );
  }
}
