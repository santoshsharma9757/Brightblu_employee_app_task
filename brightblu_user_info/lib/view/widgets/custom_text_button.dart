import 'package:brightblu_user_info/constant/app_constant.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String text;
  final Color iconColor;

  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text,
    this.iconColor = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: iconColor,
          ),
          AppSpacing.verticalSmall,
          Text(
            text,
            style: TextStyle(
              color: iconColor,
            ),
          ),
        ],
      ),
    );
  }
}
