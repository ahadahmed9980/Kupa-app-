import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocerapp/pages/home.dart';
import 'package:grocerapp/pages/widgetsall/fonthelper.dart';
import 'package:grocerapp/pages/widgetsall/golbal.dart' as globals;

import 'package:grocerapp/secret/keys.dart';
import 'package:http/http.dart' as http;

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  Map<String, dynamic>? paymentIntent;
  String? name, id;

  getuserdetails() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("User")
        .doc(globals.uid)
        .get();
    var name = doc['Name'];
    var id = doc['uid'];
  }

  final Map<String, Uint8List?> imageCache = {};
  int deliveryCharge = 170;

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

  //move to order from cartsec
  Future<void> movecarttoorder() async {
    try {
      QuerySnapshot cartsnapshot = await FirebaseFirestore.instance
          .collection("User")
          .doc(globals.uid)
          .collection("Cart")
          .get();
          //.map((doc) { ... }): Ye aik loop ki tarah kaam karta hai jo har document ke andar jata hai.
      List<Map<String, dynamic>> cartItemList = cartsnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();
      if (cartItemList.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection("Orders")
            .doc(globals.uid)
            .set({'all items': cartItemList, "order date": DateTime.now()});
        print("Data successfully moved ");
      }
    } catch (e) {
      print(e);
    }
  }

  final Stream<QuerySnapshot> cartStream = FirebaseFirestore.instance
      .collection("User")
      .doc(globals.uid)
      .collection("Cart")
      .snapshots();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserdetails();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: cartStream,
      builder: (context, snapshot) {
        double subtotal = 0;

        if (snapshot.hasData) {
          for (var doc in snapshot.data!.docs) {
            var price = doc['totalprice'] ?? 0;
            subtotal += double.tryParse(price.toString()) ?? 0;
          }
        }

        double finalTotal = subtotal + deliveryCharge;

        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              // Header
              Container(
                margin: EdgeInsets.only(left: 10.w, top: 50.h, right: 15.w),
                padding: EdgeInsets.only(bottom: 10.h),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0xFFE9E8E8))),
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

              // Cart List
              Expanded(
                child: snapshot.connectionState == ConnectionState.waiting
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF9F0F0F),
                        ),
                      )
                    : (!snapshot.hasData || snapshot.data!.docs.isEmpty)
                    ? const Center(child: Text("Your Cart is Empty"))
                    : ListView.builder(
                        padding: EdgeInsets.only(top: 10.h),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final doc = snapshot.data!.docs[index];
                          return cartItem(
                            doc["title"] ?? "No Title",
                            doc["price"].toString(),
                            doc["image"] ?? "",
                            doc["quantity"].toString(),
                            doc.id,
                          );
                        },
                      ),
              ),

              SizedBox(height: 10.h),

              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const Home()),
                  );
                },
                child: Text(
                  "+ Add more items",
                  style: Fonthelper.mediumTextstyle(
                    fontsize: 16.sp,
                    color: const Color(0xFF9F0F0F),
                  ),
                ),
              ),

              SizedBox(height: 20.h),
            ],
          ),
          bottomNavigationBar: SafeArea(
            child: checkoutSection(
              subtotal.toStringAsFixed(0),
              finalTotal.toStringAsFixed(0),
            ),
          ),
        );
      },
    );
  }

  // Cart Item Widget
  Widget cartItem(
    String name,
    String price,
    String image,
    String quantity,
    String docId,
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
            borderRadius: BorderRadius.circular(10.r),
            child: decodedBytes(image) != null
                ? Image.memory(
                    decodedBytes(image)!,
                    height: 80.h,
                    width: 80.h,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 80.h,
                    width: 80.h,
                    color: Colors.grey[200],
                    child: const Icon(Icons.image_not_supported),
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
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                onTap: () async {
                  await FirebaseFirestore.instance
                      .collection("User")
                      .doc(globals.uid)
                      .collection("Cart")
                      .doc(docId)
                      .delete();
                },
                child: const FaIcon(
                  Icons.cancel_outlined,
                  color: Color(0xFF9F0F0F),
                ),
              ),
              SizedBox(height: 30.h),
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

  // Checkout Section
  Widget checkoutSection(String sub, String total) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Fonthelper.billbars("Sub total", sub),
          const SizedBox(height: 6),
          Fonthelper.billbars("Delivery", deliveryCharge.toString()),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: Fonthelper.mediumTextstyle(fontsize: 20.sp),
                ),
                Text(
                  "Rs. $total",
                  style: Fonthelper.mediumTextstyle(
                    fontsize: 19.sp,
                    color: const Color(0xFF9F0F0F),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Fonthelper.custombutton("Checkout", () {
            makePayment(total);
          }),
        ],
      ),
    );
  }

  //payment sec
  Future<void> makePayment(String amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount, "PKR");

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          merchantDisplayName: 'Grocer App',
          style: ThemeMode.light,
        ),
      );

      await displayPaymentSheet();
    } catch (e) {
      print("Payment Error: $e");
    }
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        movecarttoorder();

        var snapshot = await FirebaseFirestore.instance
            .collection("User")
            .doc(globals.uid)
            .collection("Cart")
            .get();
        for (var doc in snapshot.docs) {
          await doc.reference.delete();
        }

        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.check_circle, color: Colors.green, size: 40),
                SizedBox(height: 10),
                Text("Payment Successful"),
              ],
            ),
          ),
        );
      });

      paymentIntent = null;
    } on StripeException catch (e) {
      print("Stripe Error: $e");
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(
    String amount,
    String currency,
  ) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretkey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      return jsonDecode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  String calculateAmount(String amount) {
    final calculatedAmount = int.parse(amount) * 100;
    return calculatedAmount.toString();
  }
}
