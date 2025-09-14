import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class TextFormFieldCustom extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final RxString? textoRx;
  final bool? obscureText;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final String? label;
  final Icon? suffixIcon;
  final bool? focus;
  final int? maxLines;
  final FocusNode? focusNode;
  final bool? readonly;
  final RxBool? tieneFocusRx;

  const TextFormFieldCustom({
    super.key,
    required this.controller,
    required this.hintText,
    this.textoRx,
    this.obscureText,
    this.validator,
    this.keyboardType,
    this.label,
    this.suffixIcon,
    this.focus,
    this.maxLines,
    this.focusNode,
    this.readonly,
    this.tieneFocusRx,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      late bool tieneTexto;
      if (textoRx != null) {
        tieneTexto = textoRx!.value.isNotEmpty;
      } else {
        tieneTexto = false;
      }

      late bool tieneFocus;
      if (tieneFocusRx != null) {
        tieneFocus = tieneFocusRx!.value;
      } else {
        tieneFocus = false;
      }

      return TextFormField(
        controller: controller,
        obscureText: obscureText ?? false,
        validator: validator,
        focusNode: focusNode,
        autofocus:focus == null ? false:true,
        keyboardType: keyboardType ?? TextInputType.text,
        maxLines: obscureText == true ? 1 : maxLines,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey[400]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey[600]!),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          suffixIcon: (tieneTexto && tieneFocus)
              ? GestureDetector(
                onTap: controller.clear,
                child: const Icon(Icons.clear),
              )
              : suffixIcon,
          errorStyle: const TextStyle(color: Colors.red),
        ),
        onChanged: textoRx != null
            ? (texto) {
          textoRx!.value = texto;

          if (texto.isEmpty) {
            textoRx!.value = '';
          }
        }
            : null,
        readOnly: readonly ?? false,
      );
    });
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