// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'package:taller/app/data/provider/internet_provider.dart';
import 'package:taller/app/services/auth_service.dart';
import 'package:taller/app/utils/snack_bar.dart';

class LoginController extends GetxController {
  final Logger log = Logger();
  static LoginController get instance => Get.find();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final btnLoginCtrl = RoundedLoadingButtonController();
  final btnLoginAppel = RoundedLoadingButtonController();
  final btnLoginGoogleCtrl = RoundedLoadingButtonController();
  final InternetProvider ip = Get.find<InternetProvider>();

  final AuthService authService;

  LoginController({
    required this.authService,
  });

  final formKey = GlobalKey<FormState>();

  // handling google sigin in
  Future handleGoogleSignIn() async {
    await InternetProvider.instance.checkInternetConnection();
    if (InternetProvider.instance.hasInternet.value == false) {
      openSnackbar(Get.context, "Check your Internet connection", Colors.red);
      btnLoginGoogleCtrl.reset();
    } else {
      try {
        await authService.signInWithGoogle();
      } catch (e) {
        openSnackbar(Get.context, "Error during Google Sign-In", Colors.red);
        log.e('Error during Google Sign-In: $e');
        btnLoginGoogleCtrl.reset();
        return;
      }
      bool userExists = false;
      try {
        userExists = await authService.userExists();
      } catch (e) {
        openSnackbar(
            Get.context,
            "El servidor no esta respondiendo por favor llame a Roberto",
            Colors.red);
            btnLoginGoogleCtrl.reset();
        return Future.value();
      }
      try {
        if (userExists) {
          btnLoginGoogleCtrl.success();
          authService.setInitialScreen();
        } else {
          try {
            await authService.saveEmpleado('GOOGLE');
            btnLoginGoogleCtrl.success();
            authService.setInitialScreen();
          } catch (e) {
            openSnackbar(
                Get.context, "Error saving employee data $e", Colors.red);
            log.e('Error saving employee data: $e');
            btnLoginGoogleCtrl.reset();
          }
        }
      } catch (e) {
        openSnackbar(
            Get.context, "Error checking user existence $e", Colors.red);
        log.e('Error checking user existence: $e');
        btnLoginGoogleCtrl.reset();
      }
    }
  }

  // sign user in method
  void signUserIn() async {
    if (!formKey.currentState!.validate()) {
      log.i("Formulario de login no correcto");
      btnLoginCtrl.reset();
    } else {
      btnLoginCtrl.success();
      log.i("El formulario de login es correcto");
      String email = usernameController.text;
      String pass = passwordController.text;
      log.i('Se va a proceder a logear al usuario con: Email -> $email');

      try {
        await authService.signInWithEmailPassword(email, pass);
        btnLoginCtrl.success();
        //Todo poner logica para ver si el empleado esta en algún taller
        authService.setInitialScreen();
      } catch (e) {
        btnLoginCtrl.reset();
        log.w(
            'Error al iniciar sesión posiblemente contraseña o email invalido');
      }
    }
  }
}
