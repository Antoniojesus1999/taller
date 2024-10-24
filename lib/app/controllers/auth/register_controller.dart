// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'package:taller/app/services/auth_service.dart';

class RegisterController extends GetxController {
  final Logger log = Logger();

  final AuthService authService;
  RegisterController({
    required this.authService,
  });

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final RoundedLoadingButtonController btnCtrl =
      RoundedLoadingButtonController();

  final passwordController2 = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future handleRegister() async {
    if (!formKey.currentState!.validate()) {
      log.w("Formulario de registro no correcto");
      btnCtrl.reset();
    } else {
      log.i("El formulario de registro es correcto");
      String email = usernameController.text;
      String pass = passwordController.text;
      log.i('Datos obtenidos del formulario de registro: Email -> $email');

      //Nota importante en la regla una vez que se crea la cuenta se inicia por defecto la sesión por eso no se hace signInWhitEmailAndPassword
      await authService.registerWithEmailPassword(email, pass).then((value) {
        // user does not exist
        authService.saveEmpleado('EMAIL_AND_PASSWORD').then((_) {
          authService.getToken();
          btnCtrl.success();
          authService.setInitialScreen();
        });
      });
    }
  }
}
