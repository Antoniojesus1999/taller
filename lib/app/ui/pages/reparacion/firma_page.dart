import 'package:signature/signature.dart';
import 'package:taller/app/controllers/reparacion/firma_cntrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global_widgets/btn_load.dart';
import '../../global_widgets/text_form_field_custom.dart';

class FirmaPage extends StatelessWidget {
  final FirmaCntrl controller = Get.find<FirmaCntrl>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Firmar documento'),
        leading: BackButton(onPressed: Get.back),
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(Get.mediaQuery.size.width * 0.05),
        child: Column(
          children: [
            Flexible(
              child: Signature(
                controller: controller.signatureController,
                backgroundColor: Colors.transparent,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BtnLoad(
                    onTap: () => controller.setDataFirma(),
                    btnController: controller.btnCntlFirmar,
                    title: 'Firmar',
                    width: Get.mediaQuery.size.width * 0.44
                ),
                BtnLoad(
                    onTap: () => controller.borrarFirma(),
                    btnController: controller.btnCntlBorrar,
                    title: 'Borrar',
                    width: Get.mediaQuery.size.width * 0.44,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
