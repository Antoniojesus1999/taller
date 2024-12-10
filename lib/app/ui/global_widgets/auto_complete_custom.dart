// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:substring_highlight/substring_highlight.dart';

class AutoCompleteCustom<T extends Object> extends StatelessWidget {
  //Esta clase es Mutable por que para que el input valla pintando la letra en roja el controller tiene que cambiar de valor una vez que se ha construido el widget
  final TextEditingController controller;
  final ValueChanged<T> onSelected;
  final List<T> options;
  final String title;
  final TextEditingValue? initValue;
  final Iterable<T> Function(TextEditingValue) optionsBuilder;
  final AutocompleteOptionToString<T> displayStringForOption; // Cambiar el tipo
  const AutoCompleteCustom({
    super.key,
    required this.controller,
    required this.optionsBuilder,
    required this.displayStringForOption,
    required this.onSelected,
    required this.options,
    required this.title,
    this.initValue,
  });

  @override
  Widget build(BuildContext context) {
    return Autocomplete<T>(
      initialValue: initValue,
      optionsBuilder: optionsBuilder,
      displayStringForOption: displayStringForOption,
      onSelected: (T value) => onSelected(value),
      optionsViewBuilder: (context, onSelected, options) {
        return Material(
          //elevation: 4,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final option = options.elementAt(index);

              return SingleChildScrollView(
                child: Card(
                  shape: Border(
                      bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.2))),
                  margin:
                      EdgeInsets.only(right: Get.mediaQuery.size.width * 0.1),
                  child: ListTile(
                    // title: Text(option.toString()),
                    title: SubstringHighlight(
                      text: option.toString(),
                      term: controller.text,
                      textStyleHighlight: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    //subtitle: const Text("This is subtitle"),
                    onTap: () {
                      onSelected(option);
                    },
                  ),
                ),
              );
            },
            //separatorBuilder: (context, index) => const Divider(),
            itemCount: options.length,
          ),
        );
      },
      fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
       
        controller = controller;
        controller.text = initValue!.text;
        
        return TextField(
          controller: controller,
          focusNode: focusNode,
          onEditingComplete: onEditingComplete,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            hintText: title,
            prefixIcon: const Icon(Icons.search),
          ),
        );
      },
    );
  }
}
