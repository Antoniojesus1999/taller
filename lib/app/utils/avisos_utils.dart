import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taller/app/utils/constans/const.dart';

Future<bool> mostrarAviso(String titulo, String contenido, bool mostrarCheck) async {
  final prefs = await SharedPreferences.getInstance();

  final RxBool noMostrarMas = false.obs;
  bool aceptado = false;

  await Get.dialog(
    AlertDialog(
      title: (titulo != '') ?Text(titulo) :null,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(contenido),
          const SizedBox(height: 12),
          (mostrarCheck)
          ? Obx(() => CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            value: noMostrarMas.value,
            onChanged: (value) {
              noMostrarMas.value = value ?? false;
            },
            title: const Text('No volver a mostrar'),
            controlAffinity: ListTileControlAffinity.leading,
          ))
          : const SizedBox(height: 12),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (noMostrarMas.value) {
              prefs.setBool(Const.mostrarAvisoNifKey, false);
            }
            aceptado = true;
            Get.back();
          },
          child: const Text('OK'),
        ),
      ],
    ),
    barrierDismissible: false,
  );

  return aceptado;
}