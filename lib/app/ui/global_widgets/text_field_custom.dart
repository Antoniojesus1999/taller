import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class TextFieldCustom extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final RxString textoRx;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(String)? onSubmitted;
  final void Function() onClear;
  final bool? readonly;
  final RxBool? tieneFocusRx;
  final Icon? suffixIcon;
  final TextInputType? keyboardType;
  final void Function()? onTap;

  const TextFieldCustom({
    super.key,
    required this.controller,
    required this.hintText,
    required this.textoRx,
    required this.onClear,
    this.focusNode,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.readonly,
    this.tieneFocusRx,
    this.suffixIcon,
    this.keyboardType,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final tieneTexto = textoRx.value.isNotEmpty;
      late bool tieneFocus;

      if (tieneFocusRx != null) {
        tieneFocus = tieneFocusRx!.value;
      } else {
        tieneFocus = false;
      }

      return TextField(
        controller: controller,
        focusNode: focusNode,
        onEditingComplete: onEditingComplete,
        onSubmitted: onSubmitted,
        onChanged: onChanged,
        readOnly: readonly ?? false,
        keyboardType: keyboardType,
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
                onTap: onClear,
                child: const Icon(Icons.clear),
              )
              : suffixIcon,
        ),
        onTap: onTap,
      );
    });
  }
}
