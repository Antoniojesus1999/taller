import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taller/app/ui/global_widgets/text_field_custom.dart';

class AutoCompleteCustomRgp extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final LayerLink layerLink;
  final String hintText;
  final RxString textoRx;
  final Iterable<String> Function(TextEditingValue, bool) obtenerOpciones;
  final void Function(BuildContext context, List<String> sugerencias) mostrarSugerencias;
  final void Function() ocultarSugerencias;
  final void Function() onClear;
  final bool? readonly;
  final RxBool? tieneFocusRx;
  final Icon? suffixIcon;
  final void Function()? onTap;

  const AutoCompleteCustomRgp({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.layerLink,
    required this.hintText,
    required this.textoRx,
    required this.obtenerOpciones,
    required this.mostrarSugerencias,
    required this.ocultarSugerencias,
    required this.onClear,
    this.readonly,
    this.tieneFocusRx,
    this.suffixIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: TextFieldCustom(
        controller: controller,
        focusNode: focusNode,
        hintText: hintText,
        textoRx: textoRx,
        onChanged: (texto) {
          texto = texto.trim().toUpperCase();
          controller.text = texto;
          textoRx.value = texto;

          if (texto.isEmpty) {
            ocultarSugerencias();
            onClear.call();
            return;
          }

          final sugerencias = obtenerOpciones(TextEditingValue(text: texto), true).toList();

          if (sugerencias.isNotEmpty) {
            mostrarSugerencias(context, sugerencias);
          } else {
            ocultarSugerencias();
          }
        },
        onClear: onClear,
        readonly: readonly ?? false,
        tieneFocusRx: tieneFocusRx,
        suffixIcon: suffixIcon,
        onTap: onTap,
      ),
    );
  }
}
