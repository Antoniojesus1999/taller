import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:taller/app/utils/avisos_utils.dart';
import 'package:taller/app/utils/micro_utils.dart';
import 'package:taller/app/utils/string_utiles.dart';

import '../utils/email_voice_to_text.dart';

class MicroService extends GetxService {
  final stt.SpeechToText _speech = stt.SpeechToText();
  String? localeId;
  bool isInitialized = false;
  FocusNode? _currentFocusNode;

  void setCurrentFocus(FocusNode focusNode) {
    _currentFocusNode = focusNode;
  }

  Future<bool> initialize() async {
    isInitialized = await _speech.initialize(
      onStatus: (status) => print('🎤 Estado: \$status'),
      onError: (error) {
        print('❌ Error: $error');
        _currentFocusNode?.unfocus();
      },
    );
    if (isInitialized) {
      final systemLocale = await _speech.systemLocale();
      localeId = systemLocale?.localeId;
    }
    return isInitialized;
  }

  Future<void> startListening({
    required BuildContext context,
    required String focus,
    required FocusNode focusNode,
    required TextEditingController controlador,
    required RxString textoRx,
    required RxBool isListening,
    Iterable<String> Function(TextEditingValue, bool)? obtenerOpciones,
    void Function(BuildContext, List<String>)? mostrarSugerencias,
    void Function()? ocultarSugerencias,
  }) async {
    setCurrentFocus(focusNode);

    _speech.listen(
      onResult: (result) {
        if (focus == "nif") {
          onResultNif(
              result: result,
              nifCntrl: controlador,
              textoRx: textoRx,
              isListenig: isListening,
              obtenerOpciones: obtenerOpciones,
              mostrarSugerencias: mostrarSugerencias,
              ocultarSugerencias: ocultarSugerencias,
              context: context);
        } else if (focus == "email") {
          onResultEmail(
              result: result,
              emailCntrl: controlador,
              textoRx: textoRx,
              isListenig: isListening,
              context: context);
        } else if (focus == "tlf") {
          onResultTlf(
              result: result,
              emailCntrl: controlador,
              textoRx: textoRx,
              isListenig: isListening,
              context: context);
        } else {
          onResult(
              result: result,
              controller: controlador,
              textoRx: textoRx,
              isListenig: isListening);
        }
      },
      listenOptions: stt.SpeechListenOptions(
        listenMode: stt.ListenMode.dictation,
        partialResults: true,
        cancelOnError: false,
        onDevice: false,
      ),
      pauseFor: Duration(seconds: 15),
      localeId: 'es_ES',
    );

  }

  void onResultNif({
    required SpeechRecognitionResult result,
    required TextEditingController nifCntrl,
    required RxString textoRx,
    required RxBool isListenig,
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


      nifCntrl
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

      isListenig.value = false;
    }
  }

  void onResultEmail({
    required SpeechRecognitionResult result,
    required TextEditingController emailCntrl,
    required RxString textoRx,
    required RxBool isListenig,
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
          emailCntrl
            ..text = textoRx.value
            ..selection = TextSelection.collapsed(offset: textoRx.value.length);
        }
      }

      isListenig.value = false;
    }
  }

  void onResultTlf({
    required SpeechRecognitionResult result,
    required TextEditingController emailCntrl,
    required RxString textoRx,
    required RxBool isListenig,
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
          emailCntrl
            ..text = textoRx.value
            ..selection = TextSelection.collapsed(offset: textoRx.value.length);
        } else {
          mostrarAviso('', 'El campo teléfono sólo admite números', false);
        }
      }

      isListenig.value = false;
    }
  }

  void onResult({
    required SpeechRecognitionResult result,
    required TextEditingController controller,
    required RxString textoRx,
    required RxBool isListenig,
  }) {
    if (result.finalResult) {
      textoRx.value += capitalizeFirstLetter(result.recognizedWords.trim());

      controller
        ..text = textoRx.value
        ..selection = TextSelection.collapsed(offset: textoRx.value.length);

      isListenig.value = false;
    }
  }
  
  void stopListening() {
    _speech.stop();
  }


}
