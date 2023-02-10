import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shogi_game/constraints/app_color.dart';
import 'package:shogi_game/constraints/app_text.dart';
import 'package:shogi_game/pages/top_page.dart';
import 'package:shogi_game/ui_component/background_image.dart';
import 'package:shogi_game/ui_component/button.dart';
import 'package:shogi_game/ui_component/input_name.dart';

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
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
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
              if (widget.battleNumber == BattleNumber.twoPlayers) ...{
                twoPlayers(),
              },
              if (widget.battleNumber == BattleNumber.manyPlayers) ...{
                manyPlayers(),
              },
              Expanded(flex: calcFlex3(), child: Container()),
              Button(
                  buttonText: widget.battleNumber == BattleNumber.manyPlayers
                      ? AppText.inputName
                      : AppText.startGame,
                  onTap: () {}),
              const SizedBox(height: 102),
            ],
          )
        ],
      ),
    );
  }

  Widget manyPlayers() {
    return Container(
      height: 156,
      width: MediaQuery.of(context).size.width - 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: AppColor.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16,
          bottom: 26,
          left: 20,
          right: 30,
        ),
        child: Column(
          children: [
            adjust(AppText.numberOfPeople, AppText.tenPeople),
            const SizedBox(height: 38),
            adjust(AppText.allottedTime, AppText.tenMinutes),
          ],
        ),
      ),
    );
  }

  Widget twoPlayers() {
    return Container(
      height: 377,
      width: MediaQuery.of(context).size.width - 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: AppColor.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 17,
          left: 20,
          right: 15,
          bottom: 21,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            firstMoveOrSecondMoveText(AppText.firstMove),
            const SizedBox(height: 6),
            InputName(controller: _controller3),
            const SizedBox(height: 28),
            firstMoveOrSecondMoveText(AppText.secondMove),
            const SizedBox(height: 6),
            InputName(controller: _controller2),
            const SizedBox(height: 45),
            adjust(AppText.allottedTime, AppText.tenMinutes),
          ],
        ),
      ),
    );
  }

  Widget firstMoveOrSecondMoveText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        color: AppColor.textColorBlack,
      ),
    );
  }

  Widget adjust(String text, String numberText) {
    return Row(
      children: [
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w400,
              color: AppColor.textColorBlack,
            ),
          ),
        ),
        Text(
          numberText,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w400,
            color: AppColor.textColorBlack,
          ),
        ),
        const SizedBox(width: 32),
      ],
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
            InputName(controller: _controller),
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
