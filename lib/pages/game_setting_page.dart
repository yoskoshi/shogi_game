import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shogi_game/constraints/app_color.dart';
import 'package:shogi_game/constraints/app_text.dart';
import 'package:shogi_game/pages/game_page.dart';
import 'package:shogi_game/pages/top_page.dart';
import 'package:shogi_game/providers/one_player_game_setting_notifier.dart';
import 'package:shogi_game/providers/two_player_game_setting_notifier.dart';
import 'package:shogi_game/ui_component/background_image.dart';
import 'package:shogi_game/ui_component/button.dart';
import 'package:shogi_game/ui_component/input_name.dart';

class GameSettingPage extends ConsumerStatefulWidget {
  final BattleNumber battleNumber;

  const GameSettingPage({Key? key, required this.battleNumber})
      : super(key: key);

  @override
  ConsumerState<GameSettingPage> createState() => _GameSettingPage();
}

class _GameSettingPage extends ConsumerState<GameSettingPage> {
  bool switchValue = true;
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final List<DropdownMenuItem<String>> _items = [];
  String _selectItem = " ";

  @override
  void initState() {
    super.initState();
    setItems();
    _selectItem = _items[0].value!;
  }

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
                onePlayer(widget.battleNumber),
              },
              if (widget.battleNumber == BattleNumber.twoPlayers) ...{
                twoPlayers(widget.battleNumber),
              },
              if (widget.battleNumber == BattleNumber.manyPlayers) ...{
                manyPlayers(),
              },
              Expanded(flex: calcFlex3(), child: Container()),
              Button(
                  buttonText: widget.battleNumber == BattleNumber.manyPlayers
                      ? AppText.inputName
                      : AppText.startGame,
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const GamePage()));
                  }),
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

  Widget twoPlayers(BattleNumber battleNumber) {
    return Container(
      height: 387,
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
            InputName(
                controller: _controller3,
                isFirstMove: true,
                battleNumber: battleNumber),
            const SizedBox(height: 28),
            firstMoveOrSecondMoveText(AppText.secondMove),
            const SizedBox(height: 6),
            InputName(
                controller: _controller2,
                isFirstMove: false,
                battleNumber: battleNumber),
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
    final twoPlayersGameSettingNotifier =
        ref.read(twoPlayersGameSettingProvider.notifier);
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
        DropdownButton(
          items: _items,
          value: _selectItem,
          onChanged: (value) {
            setState(() {
              _selectItem = value!;
            });
            twoPlayersGameSettingNotifier.updateWaitName(_selectItem);
          },
        ),
        const SizedBox(width: 32),
      ],
    );
  }

  Widget onePlayer(BattleNumber battleNumber) {
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
                      final onePlayerGameSettingNotifier =
                          ref.read(onePlayerGameSettingProvider.notifier);
                      setState(() {
                        switchValue = value;
                      });
                      onePlayerGameSettingNotifier
                          .updateFirstMoveOrSecondMove(switchValue);
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
            InputName(controller: _controller, battleNumber: battleNumber),
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

  void setItems() {
    _items
      ..add(
        const DropdownMenuItem(
          value: "10分",
          child: Text(
            "10分",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w400,
              color: AppColor.textColorBlack,
            ),
          ),
        ),
      )
      ..add(const DropdownMenuItem(
        value: "30分",
        child: Text(
          "30分",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w400,
            color: AppColor.textColorBlack,
          ),
        ),
      ))
      ..add(const DropdownMenuItem(
        value: "1時間",
        child: Text(
          "1時間",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w400,
            color: AppColor.textColorBlack,
          ),
        ),
      ))
      ..add(const DropdownMenuItem(
        value: "2時間",
        child: Text(
          "2時間",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w400,
            color: AppColor.textColorBlack,
          ),
        ),
      ))
      ..add(const DropdownMenuItem(
        value: "4時間",
        child: Text(
          "4時間",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w400,
            color: AppColor.textColorBlack,
          ),
        ),
      ));
  }
}
