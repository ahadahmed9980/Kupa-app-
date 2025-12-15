import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocerapp/pages/home.dart';
import 'package:grocerapp/pages/widgetsall/fonthelper.dart';

class Detailpage extends StatefulWidget {
  final String documentId;
  final String productId;
  const Detailpage({
    super.key,
    required this.documentId,
    required this.productId,
  });

  @override
  State<Detailpage> createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 15.w, top: 50.h, right: 15.w),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: const Color.fromARGB(255, 233, 232, 232),
                      width: 01,
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
                      style: Fonthelper.mediumTextstyle(fontsize: 23),
                    ),
                    FaIcon(Icons.shopping_cart_outlined, color: Colors.black),
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

                  child: Image.asset(
                    "assets/images/frontburger001.png",
                    height: 50.h,
                    width: 90.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 10),

              Container(
                margin: EdgeInsets.only(left: 4.w, right: 4.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Chicken Salad With Eggs",
                          style: Fonthelper.mediumTextstyle(
                            fontsize: 22,
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
                              "RS. 600",
                              style: Fonthelper.mediumTextstyle(
                                fontsize: 29.sp,
                                color: Color(0xFF9F0F0F),
                                font: FontWeight.w900,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              "RS. 300",
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.blueGrey,
                                fontSize: 15.sp,
                              ),
                            ),
                          ],
                        ),

                        // RIGHT SIDE (Title)
                        Text(
                          "Burger",
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
                            fontsize: 17,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(width: 7.w),
                        Text(
                          "400g",
                          style: Fonthelper.mediumTextstyle(fontsize: 17),
                        ),
                      ],
                    ),
                    SizedBox(height: 7.h),
                    Row(
                      children: [
                        Fonthelper.customsmallbutton(
                          "Details",
                          () {},
                          null,
                          null,
                        ),
                        SizedBox(width: 10.w),
                        Fonthelper.customsmallbutton(
                          "Reviews",
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
                        padding: EdgeInsets.only(
                          top: 9.h,
                          left: 12.w,
                          right: 15.w,
                        ),
                        height: 100.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Color(0xFFececf8)),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          "hello--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------",
                          style: Fonthelper.mediumTextstyle(fontsize: 15),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
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
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF9F0F0F),
                                      shape: BoxShape.circle,
                                    ),
                                    child: FaIcon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    '$quantity',
                                    style: Fonthelper.mediumTextstyle(
                                      fontsize: 25,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (quantity > 1) {
                                        quantity--;
                                      }
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
                                      weight: 10,
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
                          "Order Now",
                          () {},
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
        ),
      ),
    );
  }
}
