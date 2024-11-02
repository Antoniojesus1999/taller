import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/reparacion/form_danyos_cntrl.dart';
import '../../global_widgets/btn_load.dart';

class ImageWithMarkers extends StatelessWidget {
  final FormDanyosCntrl controller = Get.put(FormDanyosCntrl());

  ImageWithMarkers({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.onImageLoaded();
    });

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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Image.asset(
                                'assets/images/car_plane.png',
                                fit: BoxFit.contain,
                                key: controller.imageKey, // No longer needed for size calculation
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
                                    child: Container(
                                      width: 21,
                                      height: 21,
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                          SizedBox(height: Get.mediaQuery.size.height * 0.02),
                          BtnLoad(
                            onTap: () => controller.setDataDanyos(),
                            btnController: controller.btnCntlDanyos,
                            title: 'Continuar'
                          ),
                        ],
                      )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      // Same content as in portrait mode
                      children: [
                        Image.asset(
                          'assets/images/car_plane.png',
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
                              child: Container(
                                width: 21,
                                height: 21,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
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