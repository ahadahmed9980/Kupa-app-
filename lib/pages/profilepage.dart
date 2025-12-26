import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocerapp/pages/widgetsall/fonthelper.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "My Account",
              style: Fonthelper.mediumTextstyle(fontsize: 23.sp),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1.h, thickness: 1.sp, color: Colors.grey),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.only(left: 15.w, right: 15.w),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Ahad", style: Fonthelper.headLineTextsyle()),
                SizedBox(height: 4.h),
                Text(
                  "View profile",
                  style: Fonthelper.headLineTextsyle(fontsize: 18),
                ),
                SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Fonthelper.profilecontainer(
                      Icons.receipt_outlined,
                      "Orders",
                    ),

                    Fonthelper.profilecontainer(
                      Icons.favorite_outline,
                      "Favourite",
                    ),
                    Fonthelper.profilecontainer(
                      Icons.location_on_outlined,
                      "Address",
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
                Container(
                  height: 65.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    children: [
                      Container(child: Image.asset("assets/images/image.png")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
