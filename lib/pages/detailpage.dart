import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocerapp/pages/cart.dart';
import 'package:grocerapp/pages/detailpage.dart';
import 'package:grocerapp/pages/home.dart';
import 'package:grocerapp/pages/widgetsall/fonthelper.dart';

import 'dart:typed_data';

import 'dart:convert';

import 'package:skeletonizer/skeletonizer.dart';

class Detailpage extends StatefulWidget {
  final String documentId;
  final String productId;
  final String price;

  const Detailpage({
    super.key,
    required this.documentId,
    required this.productId,
    required this.price,
  });

  @override
  State<Detailpage> createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  Uint8List? decodebytes(String base64) {
    if (imageCache.containsKey(base64)) {
      return imageCache[base64];
    }
    try {
      final bytes = base64Decode(base64);
      imageCache[base64] = bytes;
      return bytes;
    } catch (e) {
      print("Base64 decode error: $e");
      return null;
    }
  }

  final Map<String, Uint8List?> imageCache = {};
  final uid = FirebaseAuth.instance.currentUser!.uid;

  int quantity = 1;
  late int totalprice;
  @override
  void initState() {
    super.initState();
    totalprice = int.parse(widget.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Foodtile")
            .doc(widget.documentId)
            .collection("Products")
            .doc(widget.productId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {}

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text("No data found"));
          }
          final docdata = snapshot.data!;

          return productdetail(
            docdata["price"] ?? 0,
            docdata["discount"]?.toString() ?? "No discount",
            docdata["title"]?.toString() ?? "No title",
            docdata["image"]?.toString() ?? "No image",
            docdata["description"]?.toString() ?? "No description",
            docdata["things"]?.toString() ?? "",
          );
        },
      ),
    );
  }
  //widget of

  Widget productdetail(
    dynamic priceof,
    String discountof,
    String nameof,
    String image,
    String detailof,
    String things0f,
  ) {
    return Container(
      margin: EdgeInsets.only(left: 15.w, top: 50.h, right: 15.w),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: const Color.fromARGB(255, 233, 232, 232),
                  width: 01.w,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                  child: FaIcon(Icons.arrow_back),
                ),
                Text(
                  "Food Details",
                  style: Fonthelper.mediumTextstyle(fontsize: 23.sp),
                ),
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Cart()),
                  ),
                  child: FaIcon(
                    Icons.shopping_cart_outlined,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            margin: EdgeInsets.only(left: 4.w, right: 4.w, top: 10.h),
            height: 400.h,
            width: double.infinity,
            decoration: BoxDecoration(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),

              child: decodebytes(image) != null
                  ? Image.memory(
                      decodebytes(image)!,
                      height: 50.h,
                      width: 90.w,
                      fit: BoxFit.cover,
                    )
                  : SizedBox(),
            ),
          ),
          SizedBox(height: 10.h),

          Container(
            margin: EdgeInsets.only(left: 4.w, right: 4.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$nameof',
                      style: Fonthelper.mediumTextstyle(
                        fontsize: 22.sp,
                        font: FontWeight.w600,
                      ),
                    ),
                    FaIcon(
                      Icons.favorite_border_rounded,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          priceof,
                          style: Fonthelper.mediumTextstyle(
                            fontsize: 29.sp,
                            color: Color(0xFF9F0F0F),
                            font: FontWeight.w900,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          '$discountof',
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.blueGrey,
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),

                    Text(
                      "${widget.documentId}",
                      style: Fonthelper.mediumTextstyle(
                        fontsize: 20.sp,
                        color: Color(0xFF9F0F0F),
                        font: FontWeight.w900,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    FaIcon(
                      Icons.star_border_purple500_outlined,
                      color: Color(0xFF9F0F0F),
                      //  const Color.fromARGB(255, 215, 215, 5),
                    ),
                    Text(
                      "4.6",
                      style: Fonthelper.mediumTextstyle(fontsize: 17),
                    ),
                    Text(
                      "(203 Ratings)",
                      style: Fonthelper.mediumTextstyle(
                        fontsize: 17.sp,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(width: 7.w),
                    Text(
                      "$things0f",
                      style: Fonthelper.mediumTextstyle(fontsize: 17.sp),
                    ),
                  ],
                ),
                SizedBox(height: 7.h),
                Row(
                  children: [
                    Fonthelper.customsmallbutton('Details', () {}, null, null),
                    SizedBox(width: 10.w),
                    Fonthelper.customsmallbutton(
                      'Rs. $totalprice',
                      () {},
                      Colors.white,
                      Colors.black,
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                //description
                Material(
                  borderRadius: BorderRadius.circular(15.r),
                  elevation: 1,
                  child: Container(
                    padding: EdgeInsets.only(top: 9.h, left: 12.w, right: 15.w),
                    height: 100.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Color(0xFFececf8)),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      '$detailof',
                      style: Fonthelper.mediumTextstyle(fontsize: 15.sp),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //main box row
                  children: [
                    Material(
                      elevation: 3,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),

                      child: Container(
                        padding: EdgeInsets.all(5),
                        height: 60.h,
                        width: 140.w,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        //icons row
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  quantity++;
                                  if (quantity > 15) {
                                    quantity--;
                                  }
                                 totalprice =
                                      quantity * int.parse(priceof.toString());
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Color(0xFF9F0F0F),
                                  shape: BoxShape.circle,
                                ),
                                child: FaIcon(Icons.add, color: Colors.white),
                              ),
                            ),

                            Container(
                              child: Text(
                                '$quantity',
                                style: Fonthelper.mediumTextstyle(
                                  fontsize: 25.sp,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (quantity > 1) {
                                    quantity--;
                                  }
                                  totalprice =
                                      quantity * int.parse(priceof.toString());
                                  print(totalprice);
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(4),

                                decoration: BoxDecoration(
                                  color: Color(0xFF9F0F0F),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.remove,
                                  weight: 10.w,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Fonthelper.customsmallbutton2(
                      "Add to cart",
                      () {
                        print(uid);
                        Fonthelper.delightsnackbar(
                          "Add to cart ",
                          Icons.notifications_active,
                          Colors.red,
                        ).show(context);
                        FirebaseFirestore.instance
                            .collection("User")
                            .doc(uid)
                            .collection("Cart")
                            .add({
                              "title": nameof,
                              "image": image,
                              "price": priceof,
                              "quantity": quantity,
                              "productid": widget.productId,
                              "totalprice": totalprice,
                            });
                      },
                      null,
                      null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
