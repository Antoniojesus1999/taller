import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class MicroService {
  final stt.SpeechToText _speech = stt.SpeechToText();
  String? localeId;
  bool isInitialized = false;

  Future<bool> initialize() async {
    isInitialized = await _speech.initialize(
      onStatus: (status) => print('🎤 Estado: \$status'),
      onError: (error) => print('❌ Error: \$error'),
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
    required TextEditingController controlador,
    required RxString textoRx,
    required Iterable<String> Function(TextEditingValue) obtenerOpcionesNif,
    required void Function(BuildContext, List<String>) mostrarSugerenciasPorVoz,
    required void Function() ocultarSugerenciasPorVoz,
  }) async {
    final disponible = await _speech.initialize(
      onStatus: (status) => print('🎤 Estado: $status'),
      onError: (error) => print('❌ Error: $error'),
    );

    if (!disponible) {
      print("🚫 No se pudo inicializar el reconocimiento de voz");
      return;
    }

    _speech.listen(
      onResult: (result) {
        if (focus == "nif") {
          onResultNif(
              result: result,
              nifCntrl: controlador,
              textoRx: textoRx,
              obtenerOpcionesNif: obtenerOpcionesNif,
              mostrarSugerenciasPorVoz: mostrarSugerenciasPorVoz,
              ocultarSugerenciasPorVoz: ocultarSugerenciasPorVoz,
              context: context);
        } else {
          //TODO: function onResultName
        }
      },
      listenOptions: stt.SpeechListenOptions(
        listenMode: stt.ListenMode.dictation,
        partialResults: true,
        cancelOnError: false,
        onDevice: false,
      ),
      localeId: localeId ?? 'es-ES',
    );
  }

  void onResultNif({
    required SpeechRecognitionResult result,
    required TextEditingController nifCntrl,
    required RxString textoRx,
    required Iterable<String> Function(TextEditingValue) obtenerOpcionesNif,
    required void Function(BuildContext, List<String>) mostrarSugerenciasPorVoz,
    required void Function() ocultarSugerenciasPorVoz,
    required BuildContext context,
  }) {
    final texto = result.recognizedWords.trim();

    if (result.finalResult) {
      final resultado = convertirPalabrasANif(texto);
      textoRx.value += resultado;

      nifCntrl
        ..text = textoRx.value
        ..selection = TextSelection.collapsed(offset: textoRx.value.length);

      final sugerencias = obtenerOpcionesNif(TextEditingValue(text: textoRx.value)).toList();

      if (sugerencias.isNotEmpty) {
        mostrarSugerenciasPorVoz(context, sugerencias);
      } else {
        ocultarSugerenciasPorVoz();
      }
    }
  }

  String convertirPalabrasANif(String texto) {
    final mapa = {
      'cero': '0',
      'uno': '1',
      'dos': '2', 'do': '2',
      'tres': '3', 'tre': '3',
      'cuatro': '4',
      'cinco': '5',
      'seis': '6', 'cei': '6', 'ceis': '6',
      'siete': '7', 'ciete': '7',
      'ocho': '8', 'osho': '8',
      'nueve': '9',
      // Letras
      'a': 'A',
      'be': 'B', 'b': 'B',
      'ce': 'C', 'c': 'C',
      'de': 'D', 'd': 'D',
      'e': 'E',
      'efe': 'F', 'f': 'F',
      'ge': 'G', 'g': 'G', 'je': 'G',
      'hache': 'H', 'ache': 'H', 'h': 'H',
      'i': 'I',
      'jota': 'J', 'j': 'J',
      'ka': 'K', 'ca': 'K', 'k': 'K',
      'ele': 'L', 'l': 'L',
      'eme': 'M', 'm': 'M',
      'ene': 'N', 'n': 'N',
      'eñe': 'Ñ', 'ñ': 'Ñ',
      'o': 'O',
      'pe': 'P', 'p': 'P',
      'cu': 'Q', 'q': 'Q',
      'erre': 'R', 'r': 'R',
      'ese': 'S', 's': 'S',
      'te': 'T', 't': 'T',
      'u': 'U',
      'uve': 'V', 'v': 'V',
      'uve doble': 'W', 'ube doble': 'W', 'w': 'W',
      'equis': 'X', 'x': 'X',
      'i griega': 'Y', 'y': 'Y',
      'zeta': 'Z', 'ceta': 'Z', 'z': 'Z'
    };

    final palabras = texto.toLowerCase().split(RegExp(r'\s+'));
    final numeros = palabras.map((p) => mapa[p]).where((n) => n != null).join();
    return numeros;
  }

  void stopListening() {
    _speech.stop();
  }


}
