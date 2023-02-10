import 'package:flutter/material.dart';
import 'package:shogi_game/constraints/app_color.dart';
import 'package:shogi_game/constraints/app_text.dart';
import 'package:shogi_game/constraints/image_path.dart';
import 'package:shogi_game/pages/game_setting_page.dart';
import 'package:shogi_game/ui_component/button.dart';

enum BattleNumber {
  onePlayer,
  twoPlayers,
  manyPlayers,
}

class TopPage extends StatelessWidget {
  const TopPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
          ),
          Column(
            children: [
              Expanded(flex: 14, child: Container()),
              const Text(
                AppText.shogiBattleRoyale,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  color: AppColor.white,
                  fontFamily: AppText.moul,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                AppText.whoIsShogiKing,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColor.white,
                ),
              ),
              Expanded(flex: 29, child: Container()),
              Button(
                  buttonText: AppText.onePlayerBattle,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const GameSettingPage(
                                battleNumber: BattleNumber.onePlayer)));
                  }),
              const SizedBox(height: 60),
              Button(buttonText: AppText.twoPlayersBattle, onTap: () {}),
              const SizedBox(height: 60),
              Button(buttonText: AppText.manyPlayersBattle, onTap: () {}),
              const SizedBox(height: 61),
            ],
          )
        ],
      ),
    );
  }
}
