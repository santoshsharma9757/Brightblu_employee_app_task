import 'package:flutter/material.dart';

class CustomDropdownFormField extends StatelessWidget {
  final String value;
  final String labelText;
  final List<String> items;
  final void Function(String?) onChanged;

  const CustomDropdownFormField({
    Key? key,
    required this.value,
    required this.labelText,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      items: items.map((item) => DropdownMenuItem<String>(
        value: item,
        child: Text(item),
      )).toList(),
      onChanged: onChanged,
    );
  }
}
