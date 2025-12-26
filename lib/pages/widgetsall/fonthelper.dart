import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Fonthelper {
  static TextStyle headLineTextsyle({
    FontWeight? fonts,
    Color? color,
    double? fontsize,
  }) {
    return TextStyle(
      color: color ?? Colors.black,
      fontSize: fontsize ?? 28.sp,
      fontWeight: fonts ?? FontWeight.w800,
    );
  }

  static TextStyle mediumTextstyle({
    FontWeight? font,
    Color? color,
    double? fontsize,
  }) {
    return TextStyle(
      color: color ?? Colors.black,
      fontSize: fontsize ?? 18.sp,
      fontWeight: font ?? FontWeight.w600,
    );
  }

  static custombutton(
    String text,
    VoidCallback callback, {
    Color? color,
    Color? colors,
    IconData? icons,
  }) {
    return Container(
      width: 320.w,
      height: 70.h,
      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 8.h),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? const Color(0xFF9F0F0F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          elevation: 7,
          shadowColor: Colors.black,
        ),
        onPressed: callback,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Agar icon mila → icon dikhado Agar icon null ho → icon ko skip kardena
            if (icons != null) ...[
              Icon(icons, color: colors ?? Colors.white, size: 20.sp),
              SizedBox(width: 10.w),
            ],
            Text(
              text,
              style: Fonthelper.mediumTextstyle(color: colors ?? Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  static customTextfield(
    TextEditingController controller,
    String text,
    IconData? icondata,
    // IconData icons,
    bool tohide,
    VoidCallback? ontap,
  ) {
    return Container(
      width: 400.w,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 2.h),

      child: Material(
        borderRadius: BorderRadius.circular(10.r),
        elevation: 2,
        shadowColor: Colors.black,

        child: TextField(
          obscureText: tohide,
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          cursorColor: Colors.black,
          cursorWidth: 2,
          cursorHeight: 30,
          style: Fonthelper.mediumTextstyle(font: FontWeight.w800),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              left: 10.w,
              right: 1.w,
              top: 15.h,
              bottom: 20.h,
            ),

            filled: true,
            fillColor: Color(0xFFFAFAFA),

            hintText: "${text}",
            hintStyle: Fonthelper.mediumTextstyle(
              fontsize: 16.sp,
              color: Colors.grey,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.grey, width: 3.w),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.grey, width: 3.w),
            ),
            // suffixIcon: Icon(Icons.email, color: Colors.black, size: 25),
            suffixIcon: icondata != null
                ? Icon(icondata, color: Colors.black)
                : IconButton(
                    onPressed: ontap,
                    icon: Icon(
                      tohide ? Icons.visibility_off : Icons.visibility,
                      color: Colors.black,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  static SearchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 10.w),
            margin: EdgeInsets.only(right: 10.0.w),
            decoration: BoxDecoration(
              color: Color(0xFFececf8),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: TextField(
              cursorColor: Colors.black,
              cursorWidth: 2,
              cursorHeight: 20,

              style: Fonthelper.mediumTextstyle(font: FontWeight.w700),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search your fav food!...",
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 10.0.w),
          padding: EdgeInsets.all(8.0.r),
          decoration: BoxDecoration(
            color: Color(0xFF9F0F0F),
            borderRadius: BorderRadius.circular(7.r),
          ),
          child: Icon(Icons.search, color: Colors.white),
        ),
      ],
    );
  }

  //custom small button
  static customsmallbutton(
    String text,
    VoidCallback callback,
    Color? color,
    Color? colors,
  ) {
    return Container(
      height: 65.h,
      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 9.h),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          overlayColor: Colors.transparent,
          backgroundColor: color ?? const Color(0xFF9F0F0F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          elevation: 7,

          shadowColor: Colors.black,
        ),
        onPressed: callback,
        child: Text(
          '$text',
          style: Fonthelper.mediumTextstyle(color: colors ?? Colors.white),
        ),
      ),
    );
  }

  static customsmallbutton2(
    String text,
    VoidCallback callback,
    Color? color,
    Color? colors,
  ) {
    return Container(
      height: 75.h,
      width: 180.w,
      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 9.h),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          overlayColor: Colors.transparent,
          backgroundColor: color ?? const Color(0xFF9F0F0F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          elevation: 7,

          shadowColor: Colors.black,
        ),
        onPressed: callback,
        child: Text(
          '$text',
          style: Fonthelper.mediumTextstyle(color: colors ?? Colors.white),
        ),
      ),
    );
  }

  static delightsnackbar(String text, IconData? icons, Color? color) {
    return DelightToastBar(
      builder: (context) {
        return ToastCard(
          leading: FaIcon(icons, size: 30, color: const Color(0xFF9F0F0F)),
          title: Text(
            "$text",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
        );
      },
      position: DelightSnackbarPosition.bottom,
      autoDismiss: true,

      snackbarDuration: Duration(seconds: 3),
    );
  }

  static billbars(String text, String bill) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        //  border: Border.all(color: Colors.black,width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(5, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: Fonthelper.mediumTextstyle(
              fontsize: 17.sp,
              color: Colors.grey,
            ),
          ),
          Text(
            "Rs. $bill",
            style: Fonthelper.mediumTextstyle(
              color: const Color(0xFF9F0F0F),
              fontsize: 19.sp,
            ),
          ),
        ],
      ),
    );
  }

  static profilecontainer(IconData? icons, String text) {
    return Container(
      height: 100,
      width: 120,
      padding: EdgeInsets.all(11.w),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        children: [
          FaIcon(icons, size: 40),
          SizedBox(height: 5.h),
          Text(text, style: Fonthelper.mediumTextstyle()),
        ],
      ),
    );
  }
}
