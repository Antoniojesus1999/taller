import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class BtnLoad extends StatelessWidget {
  final Function()? onTap;
  final RoundedLoadingButtonController btnController;
  final String title;
  final double width;

  const BtnLoad({
    super.key,
    required this.onTap,
    required this.btnController,
    required this.title,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RoundedLoadingButton(
        width: width,
        controller: btnController,
        onPressed: onTap,
        color: Colors.black, // Color de fondo negro
        borderRadius: 8,// Radio de borde
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white, // Color del texto en blanco
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
