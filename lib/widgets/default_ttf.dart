import 'package:flutter/material.dart';

class DefaultTTF extends StatelessWidget {
  const DefaultTTF(
      {Key? key,
      required this.controller,
      required this.label,
      this.suffixIcon,
      required this.prefixIcon,
      this.obscureText})
      : super(key: key);
  final TextEditingController controller;

  final String label;

  final Widget prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      controller: controller,
      validator: (val) {
        if (val!.isEmpty) {
          return 'it cant be empty';
        }
      },
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          label: Text(label),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon),
    );
  }
}
