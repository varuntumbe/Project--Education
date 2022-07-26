import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ExceptionWidget extends StatelessWidget {
  final String exception_msg;
  ExceptionWidget({Key key, this.exception_msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 0.8.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.red,
      ),
      alignment: Alignment.center,
      height: 20.h,
      width: 80.w,
      child: Text(
        this.exception_msg,
      ),
    );
  }
}
