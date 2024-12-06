import 'package:taller/app/data/models/cliente/cliente.dart';

import 'package:taller/app/routes/app_pages.dart';
import 'package:taller/app/services/cliente_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:taller/app/utils/snack_bar.dart';

class FormPersonaCntrl extends GetxController {
  final Logger log = Logger();

  //*Se usa en el formulario de persona
  final RoundedLoadingButtonController btnCntlPerson =
      RoundedLoadingButtonController();
  //formulario persona
  final GlobalKey<FormState> formKeyPerson = GlobalKey<FormState>();
  TextEditingController nameCntrl = TextEditingController();
  final surName1Cntrl = TextEditingController();
  final surName2Cntrl = TextEditingController();
  final nifCntrl = TextEditingController();
  final tlfCntrl = TextEditingController();
  final emailCntrl = TextEditingController();

  //*Seteamos el cliente que necesita la siguiente pagina para factura
  late Cliente cliente;

  //*Servicios inyectados
  final ClientService clientService;

  FormPersonaCntrl({required this.clientService});

  //* Setea la primera parte del formulario y nos da la posibilidad de meter al final de este metodo el guardado en baes de datos
  void setDataPersona() async {
    if (!formKeyPerson.currentState!.validate()) {
      log.i("Formulario de login no correcto");
      btnCntlPerson.reset();
    } else {
      btnCntlPerson.success();
      log.i("Formulario de login correcto");
/*      Cliente cliente = Cliente(nif: nifCntrl.text, nombre: nameCntrl.text);
      cliente.apellido1 = surName1Cntrl.text;
      cliente.apellido2 = surName2Cntrl.text;
      cliente.telefono = tlfCntrl.text;
      cliente.email = emailCntrl.text;*/

      cliente = Cliente(nif: nifCntrl.text, nombre: nameCntrl.text);
      cliente.apellido1 = surName1Cntrl.text;
      cliente.apellido2 = surName2Cntrl.text;
      cliente.telefono = tlfCntrl.text;
      cliente.email = emailCntrl.text;

      //clienteRequest = ClienteRequest(cliente: cliente);
      //clientService.saveClient(clienteRequest);
      try {
      //await clientService.saveCliente(cliente);
    } catch (e) {
      handleSaveClientError(e as Exception);
      return; // Detener la ejecución del método
    }

      log.i('Cliente seteado en form person ${clientService.cliente}');
      Get.toNamed(Routes.formVehicle);
      btnCntlPerson.reset();
    }
  }

  void handleSaveClientError(Exception e) {
    btnCntlPerson.reset();
    log.e('${e.toString()} el cliente tiene que tener un dni valido');
    openSnackbar(
    Get.context, 'Para pasar a la siguiente pagina tienes que introducir un dni o email valido', Colors.red);
    Get.toNamed(Routes.formPerson);
  }
}
