import 'package:taller/app/controllers/invoice/form_persona_cntrl.dart';
import 'package:taller/app/ui/global_widgets/btn_load.dart';
import 'package:taller/app/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global_widgets/text_form_field_custom.dart';

// ignore: must_be_immutable
class FormPersonPage extends StatelessWidget {
  const FormPersonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FormPersonaCntrl invoiceCntrl = Get.find<FormPersonaCntrl>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Introduzca datos de cliente'),
        leading: BackButton(onPressed: Get.back),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: invoiceCntrl.formKeyPerson,
              child: SizedBox(
                width: Get.mediaQuery.size.width * 0.9,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    TextFormFieldCustom(
                        controller: invoiceCntrl.nifCntrl,
                        validator: (value) => Helpers.validateEmpty(value),
                        hintText: 'NIF',
                        obscureText: false),
                    SizedBox(height: Get.mediaQuery.size.height * 0.02),
                    TextFormFieldCustom(
                        controller: invoiceCntrl.surName1Cntrl,
                        hintText: 'Primer apellido',
                        obscureText: false),
                    SizedBox(height: Get.mediaQuery.size.height * 0.02),
                    TextFormFieldCustom(
                        controller: invoiceCntrl.surName2Cntrl,
                        hintText: 'Segundo apellido',
                        obscureText: false),
                    SizedBox(height: Get.mediaQuery.size.height * 0.02),
                    TextFormFieldCustom(
                        controller: invoiceCntrl.emailCntrl,
                        //validator: (value) => Helpers.validateEmail(value),
                        hintText: 'Email',
                        keyboardTypeEmail: TextInputType.emailAddress,
                        obscureText: false),
                    SizedBox(height: Get.mediaQuery.size.height * 0.02),
                    TextFormFieldCustom(
                        controller: invoiceCntrl.tlfCntrl,
                        hintText: 'Telefono',
                        obscureText: false),
                    SizedBox(height: Get.mediaQuery.size.height * 0.13),
                    BtnLoad(
                        onTap: () => invoiceCntrl.setDataPersona(),
                        btnController: invoiceCntrl.btnCntlPerson,
                        title: 'Continuar'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
