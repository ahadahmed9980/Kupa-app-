import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Container()
    );
  }

      
    
}
