import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:grocerapp/pages/widgetsall/fonthelper.dart';
import 'package:grocerapp/pages/widgetsall/golbal.dart' as globals;

class Orderpage extends StatefulWidget {
  const Orderpage({super.key});

  @override
  State<Orderpage> createState() => _OrderpageState();
}

class _OrderpageState extends State<Orderpage> {
  final Map<String, Uint8List?> imageCache = {};

  // Image decoding
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
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10.w, top: 50.h, right: 15.w),
            padding: EdgeInsets.only(bottom: 10.h),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFE9E8E8))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              
                Text(
                  "My Orders",
                  style: Fonthelper.mediumTextstyle(fontsize: 23.sp),
                ),
             
              ],
            ),
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Userorders")
                .doc(globals.uid)
                .collection("Orders")
                .orderBy("order date", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Container(
                  margin: EdgeInsets.only(top: 40.h),
                  
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("No order yet",style: Fonthelper.headLineTextsyle(),),
                      Text("Hungry? Place an order and it'll show here.",style: Fonthelper.mediumTextstyle(),maxLines: 1,overflow: TextOverflow.ellipsis,)
                    ],
                  ),
                ));
              }
              if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              }

              return Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 10.h),
                  itemCount: snapshot.data!.docs.length,

                  itemBuilder: (context, index) {
                    double grandtotal = 0;

                    int quant = 0;

                    int order = index + 1;
                    String ordersstring = order.toString();
                    final doc = snapshot.data!.docs[index];
                    List<dynamic> itemlist = doc['all items'] ?? [];
                    final status = doc["statue"];
                    final date = doc["order date"];
                    String orderdate = "";

                    if (date is Timestamp) {
                      DateTime dt = date.toDate();
                      orderdate = "${dt.day}/${dt.month}/${dt.year}";
                    } else {
                      // Agar data null ya kisi aur format mein hai
                      orderdate = "No Date";
                    }

                    String title = itemlist.isNotEmpty
                        ? itemlist[0]["title"]
                        : "no title";
                    if (itemlist.length > 1) {
                      title = "$title + ${itemlist.length - 1} more";
                    }

                    for (var item in itemlist) {
                      double total =
                          double.tryParse(item['totalprice'].toString()) ?? 0.0;
                      int totalquantity =
                          int.tryParse(item['quantity'].toString()) ?? 0;
                      quant += totalquantity;
                      grandtotal += total;
                    }
                    String gandtotalstring = grandtotal.toString();
                    String quantstring = quant.toString();
                    return Container(
                      child: orderItem(
                        title,
                        gandtotalstring,
                        quantstring,
                        ordersstring,
                        orderdate,
                        status,
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget orderItem(
    String name,
    String price,
    String quantity,
    String orderno,
    String date,
    String status,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h, left: 15.w),
      padding: EdgeInsets.all(10.r),
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
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50.r),
            child: Container(
              color: const Color(0xFF9F0F0F),
              height: 80.h,
              width: 80.h,

              child: Center(
                child: Text(
                  orderno,
                  style: Fonthelper.mediumTextstyle(
                    fontsize: 25.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  "Rs. $price",
                  style: TextStyle(
                    fontSize: 17.sp,
                    color: const Color(0xFF9F0F0F),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.r),
                     color: const Color(0xFF9F0F0F),
                  ),
                 
                  child: Text(
                    "Status: $status",
                    style: Fonthelper.mediumTextstyle(
                      color: Colors.white,
                      fontsize: 15.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                 padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.r),
                      color: const Color.fromARGB(255, 41, 107, 43),
                     
                  ),
              
                child: Text(
                  "Paid",
                  style: Fonthelper.mediumTextstyle(color: Colors.white,fontsize: 15.sp),
                ),
              ),
              Text(date),
              SizedBox(height: 10.h,),

              RichText(
                text: TextSpan(
                  text: "Quantity: ",
                  style: Fonthelper.mediumTextstyle(fontsize: 15.sp),
                  children: [
                    TextSpan(
                      text: quantity,
                      style: Fonthelper.mediumTextstyle(
                        fontsize: 14.sp,
                        color: const Color(0xFF9F0F0F),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
