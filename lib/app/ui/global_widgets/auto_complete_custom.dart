// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:substring_highlight/substring_highlight.dart';

// ignore: must_be_immutable
class AutoCompleteCustom extends StatelessWidget {
  //Esta clase es Mutable por que para que el input valla pintando la letra en roja el controller tiene que cambiar de valor una vez que se ha construido el widget
  TextEditingController controller;
  final ValueChanged<String> onSelected;
  final List<String> options;
  final String title;
  final TextEditingValue? initValue;

  AutoCompleteCustom({
    Key? key,
    required this.controller,
    required this.onSelected,
    required this.options,
    required this.title,
    this.initValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      initialValue: initValue,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<String>.empty();
        }
        return options.where((String option) {
          final text = textEditingValue.text.toLowerCase();
          final optionLower = option.toLowerCase();
          // Compara si la opción comienza con el texto ingresado
          return optionLower.startsWith(text);
        });
      },
      displayStringForOption: (String option) => option,
      onSelected: (String value) => onSelected(value),
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
                      bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.2))
                  ),
                  margin: EdgeInsets.only(right: Get.mediaQuery.size.width * 0.1),
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
                      onSelected(option.toString());
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
        this.controller = controller;
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
