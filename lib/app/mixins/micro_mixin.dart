import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:taller/app/controllers/micro/micro_cntrl.dart';

mixin MicroMixinRgp on GetxController {
  final SpeechToText _speech = SpeechToText();
  final MicroCntrl _microCntrl = MicroCntrl();
  final localeId = 'es_ES';
  bool isInitialized = false;
  FocusNode? _currentFocusNode;

  void setCurrentFocus(FocusNode focusNode) {
    _currentFocusNode = focusNode;
  }

  final RxBool isListening = false.obs;
  final RxBool microActivo = false.obs;

  Future<bool> initializeMicro() async {
    isInitialized = await _speech.initialize(
      onStatus: (status) => print('🎤 Estado: $status'),
      onError: (error) {
        print('❌ Error: $error');
        _currentFocusNode?.unfocus();
      },
    );
    return isInitialized;
  }

  void toggleMicro({required BuildContext context}) {
    if (microActivo.value) {
      FocusScope.of(context).unfocus();
      stopMicro();
    } else {
      microActivo.value = true;
    }
  }

  Future<void> startListening({
    required String input,
    required FocusNode focusNode,
    required TextEditingController controlador,
    required RxString textoRx,
    Iterable<String> Function(TextEditingValue, bool)? obtenerOpciones,
    void Function(BuildContext, List<String>)? mostrarSugerencias,
    void Function()? ocultarSugerencias,
    required BuildContext context,
  }) async {

    setCurrentFocus(focusNode);

    _speech.listen(
      onResult: (result) => _microCntrl.handleOnResult(
          input: input,
          result: result,
          controlador: controlador,
          textoRx: textoRx,
          isListening: isListening,
          context: context,
          obtenerOpciones: obtenerOpciones,
          mostrarSugerencias: mostrarSugerencias,
          ocultarSugerencias: ocultarSugerencias,
      ),
      listenOptions: SpeechListenOptions(
        listenMode: ListenMode.dictation,
        partialResults: true,
        cancelOnError: false,
        onDevice: false,
      ),
      pauseFor: Duration(seconds: 15),
      localeId: 'es_ES',
    );

  }

/*  void stopListening() {
    _speech.stop();
  }*/

  void stopMicro() {
//    stopListening();
    _speech.stop();
    isListening.value = false;
    microActivo.value = false;
  }

}