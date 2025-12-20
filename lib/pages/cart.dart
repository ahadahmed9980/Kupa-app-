import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocerapp/pages/home.dart';
import 'package:grocerapp/pages/widgetsall/fonthelper.dart';
import 'package:grocerapp/pages/widgetsall/golbal.dart' as globals;

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  Uint8List? decodebytes(base64) {
    if (imageCache.containsKey(base64)) {
      return base64;
    }
    try {
      final bytes = base64Decode(base64);
      return bytes;
    } catch (e) {
      print("basedecode Error $e");
      return null;
    }
  }

  int delivery = 170;

  final listviewstream = FirebaseFirestore.instance
      .collection("User")
      .doc(globals.uid)
      .collection("Cart")
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10.w, top: 50.h, right: 15.w),
            padding: EdgeInsets.only(bottom: 10.h),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: const Color.fromARGB(255, 233, 232, 232),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back),
                ),
                Text(
                  "My Cart",
                  style: Fonthelper.mediumTextstyle(fontsize: 23.sp),
                ),
                SizedBox(width: 30.w),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: listviewstream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // return CircularProgressIndicator(color: Color(0xFF9F0F0F));
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Error ${snapshot.error}"));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("Your Cart is Empty"));
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final doc = snapshot.data!.docs[index];
                    final title = doc["title"] ?? "no title";
                    final image = doc["image"] ?? "no image";
                    final price = doc["price"] ?? "no price";
                    final quantity = doc["quantity"].toString();
                    return cartsec(title, price, image, quantity);
                  },
                );
              },
            ),
          ),

          SizedBox(height: 10.h),

          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
            child: Text(
              "+ Add more items",
              style: Fonthelper.mediumTextstyle(
                fontsize: 16.sp,
                color: Color(0xFF9F0F0F),
              ),
            ),
          ),

          SizedBox(height: 20.h),
        ],
      ),

      bottomNavigationBar: SafeArea(child: checkoutsec()),
    );
  }

  Widget cartsec(
    String nameof,
    String priceof,
    String imageof,
    String quantityof,
  ) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        width: 350.w,

        padding: EdgeInsets.all(10.r),
        margin: EdgeInsets.only(bottom: 12.h, left: 15.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(5, 10),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: decodebytes(imageof) != null
                  ? Image.memory(
                      decodebytes(imageof)!,
                      height: 80.h,
                      width: 80.h,
                      fit: BoxFit.cover,
                    )
                  : Icon(Icons.error, color: Colors.white),
            ),

            SizedBox(width: 15.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nameof,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    "Rs. ${priceof}",
                    style: TextStyle(
                      fontSize: 17.sp,
                      color: Color(0xFF9F0F0F),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FaIcon(
                  Icons.cancel_outlined,
                  color: Color(0xFF9F0F0F),
                  size: 24.sp,
                ),

                SizedBox(height: 30.h),
                Row(
                  children: [
                    Container(
                      width: 90.w,
                      child: RichText(
                        text: TextSpan(
                          text: "quantity: ", // Ye base text hai
                          style: Fonthelper.mediumTextstyle(
                            fontsize: 15.sp,
                          ), // Base style
                          children: [
                            TextSpan(
                              text: quantityof,
                              style: Fonthelper.mediumTextstyle(
                                fontsize: 14.sp,
                                color: Color(0xFF9F0F0F),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  checkoutsec() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),

      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Parent ko min height dene ke liye
        children: [
          Fonthelper.billbars("Sub total", "550"),
          SizedBox(height: 6),
          Fonthelper.billbars("Delivery", "100"),

          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: Fonthelper.mediumTextstyle(fontsize: 20.sp),
                ),
                Text(
                  "Rs. 650",
                  style: Fonthelper.mediumTextstyle(
                    fontsize: 19.sp,
                    color: Color(0xFF9F0F0F),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Fonthelper.custombutton("Checkout", () {}),
        ],
      ),
    );
  }
}
