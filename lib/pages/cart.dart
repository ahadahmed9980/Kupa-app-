import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocerapp/pages/home.dart';
import 'package:grocerapp/pages/widgetsall/fonthelper.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        children: [
          // Header
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

          SizedBox(height: 10.h),

          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              children: [
                // Cart Item
                Container(
                  padding: EdgeInsets.all(10.r),
                  margin: EdgeInsets.only(bottom: 12.h),
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
                        child: Image.asset(
                          "assets/images/xyz.png",
                          height: 100.h,
                          width: 100.w,
                          fit: BoxFit.cover,
                        ),
                      ),

                      SizedBox(width: 15.w),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Zinger Burger with extra cheese and fries special deal",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              "Rs. 550",
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
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (quantity < 15) quantity++;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFF9F0F0F),
                                      shape: BoxShape.circle,
                                    ),
                                    padding: EdgeInsets.all(3),
                                    child: Icon(Icons.add, color: Colors.white),
                                  ),
                                ),

                                SizedBox(width: 5.w),

                               
                                Container(
                                  width: 30.w, 
                                  alignment: Alignment.center,
                                  child: Text(
                                    "$quantity",
                                    style: Fonthelper.mediumTextstyle(
                                      fontsize: 20.sp,
                                    ),
                                  ),
                                ),

                                SizedBox(width: 5.w),

                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (quantity > 1) quantity--;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFF9F0F0F),
                                      shape: BoxShape.circle,
                                    ),
                                    padding: EdgeInsets.all(3),
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.white,
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
          ),
        ],
      ),

      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
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
        ),
      ),
    );
  }
}
