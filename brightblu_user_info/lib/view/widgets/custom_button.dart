import 'package:brightblu_user_info/constant/app_string.dart';
import 'package:brightblu_user_info/constant/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomSubmitButton extends StatelessWidget {
  final Future<void> Function() onPressed;
  final String buttonName;
  final bool isloading;

  const CustomSubmitButton(
      {super.key,
      required this.onPressed,
      this.buttonName = "Submit",
      this.isloading = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
      ),
      child: FittedBox(
        child: Text(
          isloading ? AppString.uploadingMessage : buttonName,
          style: AppTextStyles.heading4,
        ),
      ),
    );
  }
}
