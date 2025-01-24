import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/reparacion/form_danyos_cntrl.dart';
import '../../global_widgets/btn_load.dart';

class ImageWithMarkers extends StatelessWidget {
  final FormDanyosCntrl controller = Get.find<FormDanyosCntrl>();

  ImageWithMarkers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Introduzca daños observados'),
        leading: BackButton(onPressed: Get.back),
      ),
      body: SafeArea(
        child: Center(
              child: Obx(
                () => (MediaQuery.of(context).orientation == Orientation.portrait)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Stack(
                            children: [
                              Image.asset(
                                'assets/images/car_plane_v2.png',
                                fit: BoxFit.contain,
                                key: controller.imageKey,
                                frameBuilder: (BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
                                                if (wasSynchronouslyLoaded || frame != null) {
                                                  controller.onImageLoaded();
                                                }
                                                return child;
                                              },
                              ),
                              GestureDetector(
                                onTapUp: (TapUpDetails details) {
                                  final RenderBox? imageBox = controller.imageKey.currentContext?.findRenderObject() as RenderBox?;
                                  final tapPosition = imageBox?.globalToLocal(details.globalPosition);
                                  controller.addMarker(tapPosition!);
                                },
                                child: Container(
                                  width: controller.imageWidth.value,
                                  height: controller.imageHeight.value,
                                  color: Colors.transparent,
                                ),
                              ),
                              ...controller.markers.map((marker) {
                                return Positioned(
                                  left: (marker.positionX - 10.5) * (controller.imageWidth.value / marker.origWidth),
                                  top: (marker.positionY - 10.5) * (controller.imageHeight.value / marker.origHeight),
                                  child: GestureDetector(
                                    onTapUp: (TapUpDetails details) => controller.removeMarker(marker),
                                    child: Image.asset('assets/images/danyo_v3.png', width: 30, height: 30,),
                                  ),
                                );
                              }),
                            ],
                          ),
                          SizedBox(height: Get.mediaQuery.size.height * 0.24),
                          BtnLoad(
                            onTap: () => controller.setDataDanyos(),
                            btnController: controller.btnCntlDanyos,
                            title: 'Continuar',
                            width: Get.mediaQuery.size.width * 0.9,
                          ),
                          SizedBox(height: Get.mediaQuery.size.height * 0.02),
                        ],
                      )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      // Same content as in portrait mode
                      children: [
                        Image.asset(
                          'assets/images/car_plane_v2.png',
                          fit: BoxFit.contain,
                          key: controller.imageKey,
                        ),
                        GestureDetector(
                          onTapUp: (TapUpDetails details) {
                            final RenderBox? imageBox = controller.imageKey.currentContext?.findRenderObject() as RenderBox?;
                            final tapPosition = imageBox?.globalToLocal(details.globalPosition);
                            controller.addMarker(tapPosition!);
                          },
                          child: Container(
                            width: controller.imageWidth.value,
                            height: controller.imageHeight.value,
                            color: Colors.transparent,
                          ),
                        ),
                        ...controller.markers.map((marker) {
                          return Positioned(
                            left: (marker.positionX - 10.5) * (controller.imageWidth.value / marker.origWidth),
                            top: (marker.positionY - 10.5) * (controller.imageHeight.value / marker.origHeight),
                            child: GestureDetector(
                              onTapUp: (TapUpDetails details) => controller.removeMarker(marker),
                              child: Image.asset('assets/images/danyo_v3.png', width: 30, height: 30,),
                            ),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}