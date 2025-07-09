import 'package:flutter/material.dart';
import 'package:taller/app/ui/global_widgets/opciones_lista_cliente.dart';

import 'text_field_custom.dart';

class AutoCompleteCustom extends StatelessWidget {
  final ValueChanged<String> onSelected;
  final String title;
  final TextEditingValue? initValue;
  final Iterable<String> Function(TextEditingValue) optionsBuilder;
  final AutocompleteOptionToString<String> displayStringForOption;
  final void Function(String)? onSubmitted;

  const AutoCompleteCustom({
    super.key,
    required this.optionsBuilder,
    required this.displayStringForOption,
    required this.onSelected,
    required this.title,
    this.initValue,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      initialValue: initValue,
      optionsBuilder: optionsBuilder,
      displayStringForOption: displayStringForOption,
      onSelected: onSelected,
      optionsViewBuilder: (context, onSelected, options) {
        return OpcionesListaCliente(opciones: options.toList(), onSelected: onSelected);
      },
      fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
        return TextFieldCustom(
          controller: controller,
          title: title,
          focusNode: focusNode,
          onEditingComplete: onEditingComplete,
          onSubmitted: onSubmitted,
        );
      }
    );
  }
}
