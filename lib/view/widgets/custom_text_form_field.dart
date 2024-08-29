import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.1),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
