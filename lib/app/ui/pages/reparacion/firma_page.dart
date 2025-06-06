import 'package:flutter/services.dart';
import 'package:signature/signature.dart';
import 'package:taller/app/controllers/reparacion/firma_cntrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global_widgets/btn_load.dart';

class FirmaPage extends StatelessWidget {
  final FirmaCntrl controller = Get.find<FirmaCntrl>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
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
              child: AspectRatio(
                aspectRatio: 3.6,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200], // fondo suave
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.grey[600]!, // borde de referencia
                      width: 1,
                    ),
                  ),
                  child: Signature(
                    controller: controller.signatureController,
                    backgroundColor: Colors.transparent,
                  ),
                ),
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
