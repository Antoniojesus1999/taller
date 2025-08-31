import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:substring_highlight/substring_highlight.dart';

class OpcionesListaCliente extends StatelessWidget {
  final List<String> opciones;
  final void Function(String) onSelected;

  const OpcionesListaCliente({
    super.key,
    required this.opciones,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: opciones.length,
        itemBuilder: (context, index) {
          final option = opciones[index];
          return Card(
            shape: const Border(
              bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.2)),
            ),
            margin: EdgeInsets.only(right: Get.mediaQuery.size.width * 0.1),
            child: ListTile(
              title: Text(option),
              onTap: () => onSelected(option),
            ),
          );
        },
      ),
    );
  }
}
