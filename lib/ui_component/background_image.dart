import 'package:flutter/material.dart';
import 'package:shogi_game/constraints/app_color.dart';
import 'package:shogi_game/constraints/image_path.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            AppColor.luminosityColor,
            BlendMode.luminosity,
          ),
          image: AssetImage(ImagePath.backgroundImagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
