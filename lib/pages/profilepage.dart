import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocerapp/pages/Signup.dart';

import 'package:grocerapp/pages/widgetsall/fonthelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  getname() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? name = pref.getString('name');
    setState(() {
      loadname = name ?? "";
    });
  }

  String loadname = "";
  @override
  void initState() {
    getname();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.only(left: 15.w, right: 15.w),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                      loadname,
                      style: Fonthelper.headLineTextsyle(),
                    ),
                  
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
                    padding: EdgeInsets.all(15),
                    height: 65.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 55.h,
                          width: 55.w,
                          child: Image.asset(
                            "assets/images/AA.png",
                            fit: BoxFit.contain,
                          ),
                        ),

                        Text(
                          "Kupapay Credit",
                          style: Fonthelper.mediumTextstyle(),
                        ),

                        Text(" "),
                        Text(" "),
                        Container(
                          width: 85.w,
                          child: Text(
                            "Rs. 10000",
                            style: Fonthelper.mediumTextstyle(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25.h),
            Container(
              width: double.infinity,

              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey, width: 1)),
              ),

              child: Container(
                margin: EdgeInsets.only(left: 15.w, right: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    Text("Perks for you", style: Fonthelper.headLineTextsyle()),
                    SizedBox(height: 5.h),
                    Fonthelper.profilebars(
                      Icons.workspace_premium,
                      "Become a pro",
                      const Color.fromARGB(255, 152, 25, 174),
                    ),
                    Fonthelper.profilebars(
                      Icons.emoji_events_outlined,

                      "kupa rewards",
                      null,
                    ),

                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(top: 12, bottom: 12),

                      decoration: BoxDecoration(color: Colors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FaIcon(Icons.confirmation_number_outlined, size: 40),

                          Text("Vouchers", style: Fonthelper.mediumTextstyle()),
                          Text(""),
                          Text(""),
                          Text(""),
                          Text(""),
                          Text(""),
                          Text(""),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                    Text("General", style: Fonthelper.headLineTextsyle()),
                    Fonthelper.profilebars(
                      Icons.help_outline,
                      "Help center",
                      null,
                    ),
                    Fonthelper.profilebars(
                      Icons.store_outlined,
                      "Kupa for business",
                      null,
                    ),
                    Fonthelper.profilebars(
                      Icons.description_outlined,
                      "Terms & policies",
                      null,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 7.h),
            Fonthelper.custombutton("Log out", () async {
              await FirebaseAuth.instance.signOut().then((value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Signup()),
                );
              });
            }),
            SizedBox(height: 7.h),
            Text(
              "Version 25.28",
              style: Fonthelper.mediumTextstyle(fontsize: 13.sp),
            ),
            SizedBox(height: 70.h),
          ],
        ),
      ),
    );
  }
}
