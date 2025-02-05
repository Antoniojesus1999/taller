import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../../controllers/auth/register_controller.dart';
import '../../../routes/app_pages.dart';
import '../../global_widgets/btn_load.dart';
import '../../global_widgets/text_form_field_custom.dart';
import '../../../utils/helpers.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final Logger log = Logger();
  final registerCtl = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(224, 224, 224, 1),
      body: SafeArea(
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Form(
                key: registerCtl.formKey,
                child: SizedBox(
                  width: 500,
                  height: Get.mediaQuery.size.height -
                      MediaQuery.of(context)
                          .padding
                          .top, //Obtener el alto de la pantalla
                  child: Column(
                      // mainAxisAlignment: MainAxisAlignment
                      //     .center, // Alinear al centro verticalmente
                      // crossAxisAlignment: CrossAxisAlignment
                      //     .center, // Alinea al centro horizontalmente
                      children: [
                        SizedBox(height: Get.mediaQuery.size.height * 0.08),
                        // logo
                        const Icon(
                          Icons.lock,
                          size: 100,
                        ),

                        SizedBox(height: Get.mediaQuery.size.height * 0.06),

                        // welcome back, you've been missed!
                        const Text(
                          'Registrate',
                          style: TextStyle(
                            color: Color.fromRGBO(97, 97, 97, 1),
                            fontSize: 16,
                          ),
                        ),

                        SizedBox(height: Get.mediaQuery.size.height * 0.03),

                        // username textfield
                        TextFormFieldCustom(
                          controller: registerCtl.usernameController,
                          hintText: 'Email',
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          validator: Helpers.validateEmail,
                        ),

                        SizedBox(height: Get.mediaQuery.size.height * 0.03),

                        // password textfield
                        TextFormFieldCustom(
                          controller: registerCtl.passwordController,
                          hintText: 'Contraseña',
                          obscureText: true,
                          validator: Helpers.validateEmptyPass,
                        ),
                        SizedBox(height: Get.mediaQuery.size.height * 0.03),
                        // password textfield
                        TextFormFieldCustom(
                          controller: registerCtl.passwordController2,
                          hintText: 'Confirmar contraseña',
                          validator: (value) => Helpers.validatePasword(
                              value, registerCtl.passwordController.text),
                          obscureText: true,
                        ),
                        SizedBox(height: Get.mediaQuery.size.height * 0.03),

                        BtnLoad(
                          btnController: registerCtl.btnCtrl,
                          onTap: () {
                            registerCtl.handleRegister();
                          },
                          title: "Register",
                          width: Get.mediaQuery.size.width * 0.9,
                        ),

                        SizedBox(height: Get.mediaQuery.size.height * 0.03),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                                text: TextSpan(
                                    style: const TextStyle(
                                      color: Color.fromRGBO(97, 97, 97, 1),
                                    ),
                                    text: '¿Tienes Cuenta? ',
                                    children: [
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.offAllNamed(Routes.login);
                                      },
                                    text: ' Iniciar sesión',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  )
                                ])),
                          ],
                        ),
                      ]),
                ),
              ),
            )),
      ),
    );
  }
}
