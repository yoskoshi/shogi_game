import 'package:flutter/material.dart';
import 'package:shogi_game/constraints/app_color.dart';
import 'package:shogi_game/constraints/app_text.dart';

class InputName extends StatelessWidget {
  final TextEditingController controller;
  const InputName({Key? key, required this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Text(
            AppText.name,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w400,
              color: AppColor.textColorBlack,
            ),
          ),
        ),
        SizedBox(
          width: 170,
          child: TextField(
            controller: controller,
          ),
        ),
      ],
    );
  }
}
