import 'package:taller/app/services/auth_service.dart';
import 'package:taller/app/ui/global_widgets/global_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../routes/app_pages.dart';
import '../../global_widgets/dialog_custom.dart';

class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({super.key});

  final Logger log = Logger();
  // text editing controllers
  final emailCntrl = TextEditingController();
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  final AuthService authService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(224, 224, 224, 1),
        body: SafeArea(
          child: SizedBox(
            child: Transform.translate(
              offset: const Offset(0, -40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.lock_reset_rounded,
                    size: 100,
                  ),

                  //const SizedBox(height: 50),

                  // welcome back, you've been missed!
                  const Text(
                    'Introduce tu email para resetear la contraseña',
                    style: TextStyle(
                      color: Color.fromRGBO(97, 97, 97, 1),
                      fontSize: 16,
                    ),
                  ),

                  SizedBox(height: Get.mediaQuery.size.height * 0.03),

                  SizedBox(
                    width: 500,
                    child: TextFormFieldCustom(
                      controller: emailCntrl,
                      hintText: 'Email',
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      tieneFocusRx: RxBool(false),
                    ),
                  ),

                  const SizedBox(height: 25),

                  BtnLoad(
                    onTap: () async {
                      await resetPassword(emailCntrl.text.trim());
                      showCustomDialog(
                        context: context,
                        type: DialogType.success,
                        title: 'Email enviado con exito',
                        description:
                            'Revisa tu bandeja de entrada y resetea la contraseña',
                        onOk: () => Get.offAllNamed(Routes.login),
                      );
                    },
                    title: "Enviar email",
                    width: Get.mediaQuery.size.width * 0.9,
                    btnController: btnController,
                  ),

                  SizedBox(height: Get.mediaQuery.size.height * 0.03),

                  // or continue with
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Color.fromRGBO(189, 189, 189, 1),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'o continua con:',
                            style:
                                TextStyle(color: Color.fromRGBO(97, 97, 97, 1)),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Color.fromRGBO(189, 189, 189, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.mediaQuery.size.height * 0.02),
                  // not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                          text: TextSpan(
                              style: const TextStyle(
                                color: Color.fromRGBO(97, 97, 97, 1),
                              ),
                              text: '¿No tienes cuenta? ',
                              children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.toNamed(Routes.register);
                                },
                              text: ' Regritrar',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            )
                          ])),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Future resetPassword(String email) async {
    try {
      await authService.resetPassword(email);
      btnController.success();
    } catch (e) {
      btnController.reset();
    }
  }
}
