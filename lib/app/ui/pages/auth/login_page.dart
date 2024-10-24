import 'package:taller/app/ui/global_widgets/btn_load_square.dart';
import 'package:taller/app/ui/global_widgets/global_widgets.dart';
import 'package:taller/app/utils/helpers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../../controllers/auth/login_controller.dart';
import '../../../routes/app_pages.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final Logger log = Logger();
  // text editing controllers

  final loginCtl = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(224, 224, 224, 1),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: loginCtl.formKey,
            child: SizedBox(
              width: Get.mediaQuery.size.width * 0.9,
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  // logo
                  const Icon(
                    Icons.lock,
                    size: 100,
                  ),

                  SizedBox(height: Get.mediaQuery.size.height * 0.06),

                  // welcome back, you've been missed!
/*                  const Text(
                    '¿Quieres hacer tu empresa mas productiva?',
                    style: TextStyle(
                      color: Color.fromRGBO(97, 97, 97, 1),
                      fontSize: 16,
                    ),
                  ),*/

                  SizedBox(height: Get.mediaQuery.size.height * 0.02),

                  TextFormFieldCustom(
                    controller: loginCtl.usernameController,
                    hintText: 'Email',
                    obscureText: false,
                    validator: (value) => Helpers.validateEmail(value),
                    keyboardTypeEmail: TextInputType.emailAddress,
                  ),

                  SizedBox(height: Get.mediaQuery.size.height * 0.02),

                  // password textfield
                  TextFormFieldCustom(
                    controller: loginCtl.passwordController,
                    hintText: 'Contraseña',
                    validator: Helpers.validateEmptyPass,
                    obscureText: true,
                  ),

                  const SizedBox(height: 10),

                  // forgot password?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () => Get.toNamed(Routes.reset),
                            child: const Text(
                              '¿Recuperar contraseña?',
                              style: TextStyle(
                                  color: Color.fromRGBO(117, 117, 117, 1)),
                            )),
                      ],
                    ),
                  ),

                  SizedBox(height: Get.mediaQuery.size.height * 0.02),

                  BtnLoad(
                    onTap: loginCtl.signUserIn,
                    title: "Login",
                    btnController: loginCtl.btnLoginCtrl,
                  ),

                  SizedBox(height: Get.mediaQuery.size.height * 0.02),

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

                  // google + apple sign in buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BtnLoadSquare(
                          onPressed: () {
                            loginCtl.handleGoogleSignIn();
                          },
                          controller: loginCtl.btnLoginGoogleCtrl,
                          imagePath: 'assets/images/google.png'),
                      /*const SizedBox(width: 50),
                     BtnLoadSquare(
                          onPressed: () {
                            loginCtl.handleGoogleSignIn();
                          },
                          controller: loginCtl.btnLoginAppel,
                          imagePath: 'assets/images/apple.png'),*/
                    ],
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
                                  Get.offAllNamed(Routes.register);
                                },
                              text: ' Regritrar',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            )
                          ])),
                    ],
                  ),
                  const SizedBox(height: 10)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
