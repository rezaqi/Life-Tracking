import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final IconData? icon;
  void Function(String)? onChanged;
  final String? Function(String?)? validator;
  TextStyle? hintStyle;
  final TextInputType? keyboardType;
  final int? maxLength;
  final Iterable<String>? autofillHints;

  CustomTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.obscure = false,
    this.icon,
    this.onChanged,
    this.validator,
    this.hintStyle,
    this.keyboardType,
    this.maxLength,
    this.autofillHints,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscure,
      onChanged: onChanged,
      keyboardType: keyboardType,
      maxLength: maxLength,
      autofillHints: autofillHints,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: hintStyle,
        prefixIcon: icon != null ? Icon(icon) : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
