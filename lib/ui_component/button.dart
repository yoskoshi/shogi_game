import 'package:flutter/material.dart';
import 'package:shogi_game/constraints/app_color.dart';

class Button extends StatelessWidget {
  final String buttonText;
  final void Function() onTap;
  const Button({Key? key, required this.buttonText, required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width - 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: AppColor.buttonColor,
        ),
        child: Center(
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColor.white,
            ),
          ),
        ),
      ),
    );
  }
}
