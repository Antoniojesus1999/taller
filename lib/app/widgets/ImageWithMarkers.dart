/* import 'package:flutter/material.dart';
import '../data/models/client_model.dart';


class ImageWithMarkers extends StatefulWidget {
  final List<DamageDto>? markers;

  const ImageWithMarkers({
    Key? key,
    required this.markers
  }) : super(key: key);

  @override
  _ImageWithMarkersState createState() => _ImageWithMarkersState();
}

class _ImageWithMarkersState extends State<ImageWithMarkers> with WidgetsBindingObserver {
  final GlobalKey _imageKey = GlobalKey();
  late List<DamageDto> _markers;
  double? imageWidth;
  double? imageHeight;

  @override
  void initState() {
    super.initState();
    if (widget.markers != null) {
      _markers = widget.markers!;
    } else {
      _markers = [];
    }

    WidgetsBinding.instance.addObserver(this);
    delayedExecution();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onImageLoaded();
    });
  }

  Future<void> delayedExecution() async {
    // Esperar hasta que la condición (isConditionMet) sea verdadera.
    while (imageWidth == null || imageHeight == null ||
        imageWidth == 0.0  || imageHeight == 0.0) {
      await Future.delayed(const Duration(milliseconds: 1000));
      onImageLoaded();
    }
  }

  void onImageLoaded() {
    final RenderBox imageBox = _imageKey.currentContext!.findRenderObject() as RenderBox;
    setState(() {
      imageWidth = imageBox.size.width;
      imageHeight = imageBox.size.height;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/images/car_plane.png',
                fit: BoxFit.contain,
                key: _imageKey,
              ),
              GestureDetector(
                onTapUp: (TapUpDetails details) {
                  final imageBox = _imageKey.currentContext?.findRenderObject() as RenderBox?;
                  if (imageBox != null) {
                    final tapPosition = imageBox.globalToLocal(details.globalPosition);

                    setState(() {
                      _markers.add(DamageDto(
                          position: tapPosition,
                          origWidth: imageWidth!,
                          origHeight: imageHeight!
                      ));
                    });
                  }
                }
                ,
                child: SizedBox(
                  width: imageWidth,
                  height: imageHeight,
/*                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    color: Colors.blue.withOpacity(0.5),
                  ),*/
                ),
              ),
              ..._markers.map((marker){
                return Positioned(
                  left: (marker.position!.dx -10.5) * (imageWidth! / marker.origWidth!),
                  top: (marker.position!.dy -10.5) * (imageHeight! / marker.origHeight!),
                  child: GestureDetector(
                    onTapUp: (TapUpDetails details) {
                      setState(() {
                        _markers.remove(marker);
                      });
                    }
                    ,
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
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/images/car_plane.png',
                fit: BoxFit.contain,
                key: _imageKey,
              ),
              GestureDetector(
                onTapUp: (TapUpDetails details) {
                  final imageBox = _imageKey.currentContext?.findRenderObject() as RenderBox?;
                  if (imageBox != null) {
                    final tapPosition = imageBox.globalToLocal(details.globalPosition);

                    setState(() {
                      _markers.add(DamageDto(
                          position: tapPosition,
                          origWidth: imageWidth!,
                          origHeight: imageHeight!
                      ));
                    });
                  }
                }
                ,
                child: SizedBox(
                  width: imageWidth,
                  height: imageHeight,
/*                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    color: Colors.blue.withOpacity(0.5),
                  ),*/
                ),
              ),
              ..._markers.map((marker){
                return Positioned(
                  left: (marker.position!.dx -10.5) * (imageWidth! / marker.origWidth!),
                  top: (marker.position!.dy -10.5) * (imageHeight! / marker.origHeight!),
                  child: GestureDetector(
                    onTapUp: (TapUpDetails details) {
                      setState(() {
                        _markers.remove(marker);
                      });
                    }
                    ,
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
      );
    }
  }
}
 */