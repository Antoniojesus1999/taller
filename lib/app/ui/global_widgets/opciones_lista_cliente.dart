import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          final isLast = index == opciones.length - 1;

          return Card(
            shape: isLast
                ? RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(8), // o el valor que quieras
                    ),
                  )
                : const Border(
                    bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.2)),
                  ),
            margin: EdgeInsets.only(
                right: Get.mediaQuery.size.width * 0.1,
                top: Get.mediaQuery.size.width * 0.002,
            ),
            elevation: 2.0,
            child: ListTile(
              title: Text(option),
              onTap: () => onSelected(option.split(' - ').first.trim()),
            ),
          );
        },
      ),
    );
  }
}
