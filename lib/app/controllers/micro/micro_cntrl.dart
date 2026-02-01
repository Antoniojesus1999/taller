import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:taller/app/utils/avisos_utils.dart';
import 'package:taller/app/utils/micro_utils.dart';
import 'package:taller/app/utils/string_utiles.dart';

import '../../utils/email_voice_to_text.dart';

class MicroCntrl {
  void handleOnResult({
    required String input,
    required SpeechRecognitionResult result,
    required TextEditingController controlador,
    required RxString textoRx,
    required RxBool isListening,
    Iterable<String> Function(TextEditingValue, bool)? obtenerOpciones,
    void Function(BuildContext, List<String>)? mostrarSugerencias,
    void Function()? ocultarSugerencias,
    required BuildContext context,
  }) {
    if (input == "nif") {
      onResultNif(
          result: result,
          controlador: controlador,
          textoRx: textoRx,
          isListening: isListening,
          obtenerOpciones: obtenerOpciones,
          mostrarSugerencias: mostrarSugerencias,
          ocultarSugerencias: ocultarSugerencias,
          context: context);
    } else if (input == "email") {
      onResultEmail(
          result: result,
          controlador: controlador,
          textoRx: textoRx,
          isListening: isListening,
          context: context);
    } else if (input == "tlf") {
      onResultTlf(
          result: result,
          controlador: controlador,
          textoRx: textoRx,
          isListening: isListening,
          context: context);
    } else if (input == "matricula") {
      onResultMatricula(
          result: result,
          controlador: controlador,
          textoRx: textoRx,
          isListening: isListening,
          context: context);
    } else {
      onResult(
          result: result,
          controlador: controlador,
          textoRx: textoRx,
          isListening: isListening);
    }
  }

  void onResultNif({
    required SpeechRecognitionResult result,
    required TextEditingController controlador,
    required RxString textoRx,
    required RxBool isListening,
    Iterable<String> Function(TextEditingValue, bool)? obtenerOpciones,
    void Function(BuildContext, List<String>)? mostrarSugerencias,
    void Function()? ocultarSugerencias,
    required BuildContext context,
  }) {
    if (result.finalResult) {
      final texto = result.recognizedWords.trim();
      print('texto: $texto');
      final resultado = convertirVozANif(texto);
      if (resultado.contains('ERRMIL')) {
        mostrarAviso('', 'El dictado por voz sólo reconoce números de 0 a 999', false);
      } else if (resultado.contains('ERRDIC')) {
        mostrarAviso('', 'Por favor, dicte el NIF/NIE de forma clara. Si es necesario, diga los caracteres de uno en uno.', false);
      } else {
        textoRx.value += resultado;
      }


      controlador
        ..text = textoRx.value
        ..selection = TextSelection.collapsed(offset: textoRx.value.length);

      final contieneNumeros = RegExp(r'\d').hasMatch(textoRx.value);

      String cadena;

      if (contieneNumeros) {
        cadena = textoRx.value;
      } else {
        cadena = texto;
      }

      final sugerencias = obtenerOpciones!(TextEditingValue(text: cadena), contieneNumeros).toList();

      if (sugerencias.isNotEmpty) {
        mostrarSugerencias!(context, sugerencias);
      } else {
        ocultarSugerencias!();
      }

      isListening.value = false;
    }
  }

  void onResultEmail({
    required SpeechRecognitionResult result,
    required TextEditingController controlador,
    required RxString textoRx,
    required RxBool isListening,
    required BuildContext context,
  }) {
    if (result.finalResult) {
      final texto = result.recognizedWords.trim();
      print('texto: $texto');
      final resultado = procesarEmailDictado(texto);

      print('contieNumMayorNueve: ${resultado.contieneNumeroMayorQueNueve}; email: ${resultado.email}');

      if (resultado.contieneNumeroMayorQueNueve) {
        mostrarAviso('', 'Si el email contiene números, díctelos de forma clara y uno a uno', false);
      } else {
        if (resultado.email != null) {
          textoRx.value += resultado.email!;
          controlador
            ..text = textoRx.value
            ..selection = TextSelection.collapsed(offset: textoRx.value.length);
        }
      }

      isListening.value = false;
    }
  }

  void onResultTlf({
    required SpeechRecognitionResult result,
    required TextEditingController controlador,
    required RxString textoRx,
    required RxBool isListening,
    required BuildContext context,
  }) {
    if (result.finalResult) {
      final texto = result.recognizedWords.trim();
      final resultado = convertirVozATlf(texto);

      if (resultado == 'ERROR') {
        mostrarAviso('', 'Dicta los números de forma clara y uno a uno', false);
      } else {
        if (resultado != '') {
          textoRx.value += resultado;
          controlador
            ..text = textoRx.value
            ..selection = TextSelection.collapsed(offset: textoRx.value.length);
        } else {
          mostrarAviso('', 'El campo teléfono sólo admite números', false);
        }
      }

      isListening.value = false;
    }
  }

  void onResultMatricula({
    required SpeechRecognitionResult result,
    required TextEditingController controlador,
    required RxString textoRx,
    required RxBool isListening,
    required BuildContext context,
  }) {
    if (result.finalResult) {
      final texto = result.recognizedWords.trim();
      final resultado = convertirVozAMatricula(texto);

/*      if (resultado == 'ERROR') {
        mostrarAviso('', 'Dicta los números de forma clara y uno a uno', false);
      } else {
        if (resultado != '') {
          textoRx.value += resultado;
          controlador
            ..text = textoRx.value
            ..selection = TextSelection.collapsed(offset: textoRx.value.length);
        } else {
          mostrarAviso('', 'El campo teléfono sólo admite números', false);
        }
      }*/

      isListening.value = false;
    }
  }

  void onResult({
    required SpeechRecognitionResult result,
    required TextEditingController controlador,
    required RxString textoRx,
    required RxBool isListening,
  }) {
    if (result.finalResult) {
      textoRx.value += capitalizeFirstLetter(result.recognizedWords.trim());

      controlador
        ..text = textoRx.value
        ..selection = TextSelection.collapsed(offset: textoRx.value.length);

      isListening.value = false;
    }
  }

}
