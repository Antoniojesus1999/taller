import 'dart:async';

import 'package:taller/app/services/auth_service.dart';
import 'package:taller/app/utils/snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class MailVerificationController extends GetxController {
  final Logger log = Logger();
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  final AuthService authService = Get.find();
  late Timer timer;
  bool execute = false;
  @override
  void onInit() {
    sendVerificationEmail();
    super.onInit();
  }

  Future<void> sendVerificationEmail() async {
    if (!execute) {
      try {
        execute = true;
        await authService.sendEmailVerification();
      } catch (e) {
        if (e != 'too-many-requests') {
          openSnackbar(Get.context, '$e se ha borrado el usuario de firebase',
              Colors.red);
          log.f(
              'Se ejecuta esto cuando tiene sesión iniciada pero se borra la cuenta de firebase');
        } else {
          openSnackbar(
              Get.context,
              'Se ha enviado un correo de verificación, verifica su correo',
              Colors.red);
          log.w('Enviado correo de verificación, verifica su correo');
        }
      }
      checkVerify();
      execute = false;
    }
  }

  void checkVerify() {
    int i = 0;
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      FirebaseAuth.instance.currentUser?.reload();

      final user = authService.firebaseAuth.currentUser;
      if (i == 150) {
        timer.cancel();
      }
      i += 1;
      if (user!.emailVerified) {
        timer.cancel();
        authService.setInitialScreen();
      }
    });
  }
}
