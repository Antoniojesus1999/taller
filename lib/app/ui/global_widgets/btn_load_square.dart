import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class BtnLoadSquare extends StatelessWidget {
  final Function() onPressed;
  final RoundedLoadingButtonController controller;
  final String imagePath;

  const BtnLoadSquare({
    Key? key,
    required this.onPressed,
    required this.controller,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedLoadingButton(
      height: 60,
      width: 60,
      controller: controller,
      onPressed: onPressed,
      color: const Color.fromARGB(255, 255, 255, 255),
      borderRadius: 16,
      valueColor: Colors.black,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[200],
        ),
        child: Image.asset(
          imagePath,
          height: 40,
        ),
      ),
    );
  }
}
