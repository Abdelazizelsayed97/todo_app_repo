import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowToast {
  static void showToastMessage({required String message, Color? color}) =>
      Fluttertoast.showToast(
          msg: message,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: color ?? Colors.green,
          textColor: Colors.white,
          fontSize: 14.sp);
}
