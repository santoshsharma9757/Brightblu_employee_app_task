import 'package:brightblu_user_info/constant/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppUtils {
  static snackBar(String message, BuildContext context, [bool isError=false]) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: !isError ? AppColors.green : AppColors.red,
        content: Text(message)));
  }

  // static snackBarError(String message, BuildContext context) {
  //   return ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(backgroundColor: AppColors.red, content: Text(message)));
  // }

  static void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
