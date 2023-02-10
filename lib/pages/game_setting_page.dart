import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shogi_game/constraints/app_color.dart';
import 'package:shogi_game/constraints/app_text.dart';
import 'package:shogi_game/constraints/image_path.dart';
import 'package:shogi_game/pages/top_page.dart';
import 'package:shogi_game/ui_component/button.dart';

class GameSettingPage extends StatefulWidget {
  final BattleNumber battleNumber;

  const GameSettingPage({Key? key, required this.battleNumber})
      : super(key: key);

  @override
  State<GameSettingPage> createState() => _GameSettingPage();
}

class _GameSettingPage extends State<GameSettingPage> {
  bool switchValue = true;
  final TextEditingController _controller = TextEditingController();
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
              Expanded(flex: calcFlex1(), child: Container()),
              const Text(
                AppText.gameSettings,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  fontFamily: AppText.moul,
                  color: AppColor.white,
                ),
              ),
              Expanded(flex: calcFlex2(), child: Container()),
              if (widget.battleNumber == BattleNumber.onePlayer) ...{
                onePlayer(),
              },
              Expanded(flex: calcFlex3(), child: Container()),
              Button(buttonText: AppText.startGame, onTap: () {}),
              const SizedBox(height: 102),
            ],
          )
        ],
      ),
    );
  }

  Widget onePlayer() {
    return Container(
      height: 182,
      width: MediaQuery.of(context).size.width - 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: AppColor.white,
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 22, bottom: 22, left: 14, right: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    AppText.firstMove,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textColorBlack,
                    ),
                  ),
                ),
                CupertinoSwitch(
                    value: switchValue,
                    onChanged: (value) {
                      setState(() {
                        switchValue = value;
                      });
                    }),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              AppText.ifFirstMoveOffBecomeSecondMove,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: AppColor.textColorGray,
              ),
            ),
            const SizedBox(height: 20),
            Row(
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
                    controller: _controller,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  int calcFlex1() {
    if (widget.battleNumber == BattleNumber.onePlayer) {
      return 14;
    } else {
      return 7;
    }
  }

  int calcFlex2() {
    if (widget.battleNumber == BattleNumber.onePlayer) {
      return 13;
    } else if (widget.battleNumber == BattleNumber.twoPlayers) {
      return 4;
    } else {
      return 6;
    }
  }

  int calcFlex3() {
    if (widget.battleNumber == BattleNumber.onePlayer) {
      return 21;
    } else if (widget.battleNumber == BattleNumber.twoPlayers) {
      return 4;
    } else {
      return 12;
    }
  }
}
