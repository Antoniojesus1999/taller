import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldCustom extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool? obscureText;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final String? label;
  final Icon? suffixIcon;
  final bool? focus;
  final int? maxLines;
  final FocusNode? focusNode;

  const TextFormFieldCustom({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText,
    this.validator,
    this.keyboardType,
    this.label,
    this.suffixIcon,
    this.focus,
    this.maxLines,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        obscureText: obscureText ?? false,
        validator: validator,
        focusNode: focusNode,
        autofocus:focus == null ? false:true,
        keyboardType: keyboardType ?? TextInputType.text,
        maxLines: obscureText == true ? 1 : maxLines,
/*        inputFormatters: keyboardType == TextInputType.number
          ? [ThousandsSeparatorInputFormatter()]
          : null,*/
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

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;

    // Permitir solo números y una coma
    newText = newText.replaceAll(RegExp(r'[^0-9,]'), '');

    // Evitar más de una coma
    int commaCount = newText.split(',').length - 1;
    if (commaCount > 1) {
      return oldValue; // No permitir más de una coma
    }

    List<String> parts = newText.split(',');
    String integerPart = parts[0];
    String decimalPart = parts.length > 1 ? parts[1] : '';

    // Limitar la parte decimal a 2 dígitos
    if (decimalPart.length > 2) {
      decimalPart = decimalPart.substring(0, 2);
    }

    // Formatear la parte entera con separador de miles
    String formattedInteger = integerPart.isNotEmpty
        ? integerPart.replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+$)'),
            (Match match) => '${match[1]}.')
        : '';

    // Construir el nuevo texto con formato correcto
    String formattedText = decimalPart.isNotEmpty ? '$formattedInteger,$decimalPart' : formattedInteger;

    // Ajustar la posición del cursor correctamente
    int newOffset = formattedText.length;

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: newOffset),
    );
  }
}