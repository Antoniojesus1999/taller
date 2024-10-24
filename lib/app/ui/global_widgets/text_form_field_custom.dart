import 'package:flutter/material.dart';

class TextFormFieldCustom extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardTypeEmail;
  final String? label;
  final Icon? suffixIcon;
  final bool? focus;

  const TextFormFieldCustom({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.validator,
    this.keyboardTypeEmail,
    this.label,
    this.suffixIcon, this.focus,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        autofocus:focus == null ? false:true,
        keyboardType: keyboardTypeEmail != null
            ? TextInputType.emailAddress
            : TextInputType.text,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: const Color.fromARGB(255, 238, 238, 238),
          filled: true,
          hintText: hintText,
          labelText: label,
          hintStyle: TextStyle(color: Colors.grey[500]),
          suffixIcon: suffixIcon,
          errorStyle: const TextStyle(color: Colors.red),
          
        ),
      );
  }
}
