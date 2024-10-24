import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth/mail_verification_controller.dart';

class VerifyPage extends StatelessWidget {
  VerifyPage({super.key});

  final ctrlEmailVerify = Get.find<MailVerificationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(224, 224, 224, 1),
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.email,
                size: 100,
                color: Color.fromARGB(208, 28, 31, 33),
              ),
              const SizedBox(height: 20),
              const Text(
                "¡Hemos enviado un correo!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Entra en tu correo y verifica la cuenta",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  ctrlEmailVerify.checkVerify();
                },
                child: const Text('Verificar email'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  ctrlEmailVerify.sendVerificationEmail();
                },
                child: const Text('Reenviar email de verificación'),
              ),
              const SizedBox(height: 10),
              TextButton(
                  onPressed: () {
                    ctrlEmailVerify.checkVerify();
                  },
                  style: TextButton.styleFrom(
                    textStyle:
                        const TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent, // Fondo transparente
                      elevation: 0, // Sin sombra
                    ),
                    onPressed: () {
                      Get.toNamed('/login'); // Navega a la pantalla de login
                    },
                    child: const Text(
                      'Volver al Login',
                      style: TextStyle(
                          color: Colors.blue, // Color del texto
                          decoration: TextDecoration.underline,
                          decorationThickness: 2.0 // Subraya el texto
                          ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
