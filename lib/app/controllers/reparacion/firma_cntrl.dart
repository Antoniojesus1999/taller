import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:signature/signature.dart';
import 'package:taller/app/utils/snack_bar.dart';

import '../../data/models/cliente/cliente.dart';
import '../../routes/app_pages.dart';
import '../../services/cliente_service.dart';

class FirmaCntrl extends GetxController {
  final Logger log = Logger();

  final RoundedLoadingButtonController btnCntlFirmar =
  RoundedLoadingButtonController();

  final RoundedLoadingButtonController btnCntlBorrar =
  RoundedLoadingButtonController();

  late List<Point> firmaPng;

  late SignatureController signatureController;

  //*Servicios inyectados
  final ClientService clienteService;


  FirmaCntrl({
    required this.clienteService,
  });

  @override
  void onInit() {
    super.onInit();
    initializeSignatureController();
  }

  @override
  void onClose() {
    super.onClose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    signatureController.dispose();
  }

  void initializeSignatureController() {
    if (clienteService.cliente.firma!.isNotEmpty) {
      signatureController = SignatureController(
        penStrokeWidth: 5.0,
        points: clienteService.cliente.firma,
      );
    } else {
      signatureController = SignatureController(
        penStrokeWidth: 5.0,
      );
    }
  }

  Future<void> setDataFirma() async {
    if (signatureController.isNotEmpty) {
      Cliente cliente = clienteService.cliente;
      cliente.firma = signatureController.points;
      final Uint8List? pngBytes = await signatureController.toPngBytes();

      if (pngBytes != null) {
        cliente.firmaBase64 = base64Encode(pngBytes);
      } else {
        throw Exception("No se pudo guardar la firma");
      }

      await clienteService.saveCliente(cliente);

      Get.back(result: true);

    } else {
      openSnackbar(Get.context, 'Debe dibujar una firma', Colors.red);
    }

    btnCntlFirmar.reset();
  }

  void borrarFirma() {
    signatureController.clear();
    btnCntlBorrar.reset();
  }
}