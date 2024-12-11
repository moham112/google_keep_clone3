import 'package:flutter/material.dart';

class KTextFormField extends StatelessWidget {
  final String hint;
  final bool obscurity;
  final TextEditingController? controller;
  final String? initialValue;

  KTextFormField(
      {super.key,
      required this.hint,
      this.obscurity = false,
      this.controller,
      this.initialValue});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: this.initialValue,
      // key: formState,
      controller: this.controller,
      obscureText: this.obscurity,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: "${this.hint}",
        hintStyle: TextStyle(
          color: Color(0xffb8b7bd),
          fontSize: 12,
        ),
      ),
    );
  }
}
