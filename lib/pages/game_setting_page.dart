import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shogi_game/constraints/app_color.dart';
import 'package:shogi_game/constraints/app_text.dart';
import 'package:shogi_game/pages/game_page.dart';
import 'package:shogi_game/pages/many_players_name_setting_page.dart';
import 'package:shogi_game/pages/top_page.dart';
import 'package:shogi_game/providers/many_players_game_setting_notifier.dart';
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
  final List<DropdownMenuItem<String>> _twoPlayersWaitTimeItems = [];
  final List<DropdownMenuItem<String>> _manyPlayersNumberOfPeopleItems = [];
  final List<DropdownMenuItem<String>> _manyPlayersWaitTimeItems = [];
  String _twoPlayersSelectItem = " ";
  String _manyPlayersNumberOfPeople = " ";
  String _manyPlayersWaitTime = " ";

  @override
  void initState() {
    super.initState();
    setWaitTimeItems(_twoPlayersWaitTimeItems);
    setWaitTimeItems(_manyPlayersWaitTimeItems);
    setNumberOfPeopleItems();
    _twoPlayersSelectItem = _twoPlayersWaitTimeItems[0].value!;
    _manyPlayersNumberOfPeople = _manyPlayersNumberOfPeopleItems[0].value!;
    _manyPlayersWaitTime = _manyPlayersWaitTimeItems[0].value!;
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
                    if (widget.battleNumber == BattleNumber.manyPlayers) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ManyPlayersNameSettingPage()));
                    } else {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => const GamePage()));
                    }
                  }),
              const SizedBox(height: 102),
            ],
          )
        ],
      ),
    );
  }

  Widget manyPlayers() {
    final manyPlayersGameSettingNotifier =
        ref.read(manyPlayersGameSettingProvider.notifier);
    return Container(
      height: 176,
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
            adjust(
              text: AppText.numberOfPeople,
              numberText: AppText.threePeople,
              items: _manyPlayersNumberOfPeopleItems,
              selectedItem: _manyPlayersNumberOfPeople,
              onChanged: (value) {
                setState(() {
                  _manyPlayersNumberOfPeople = value!;
                });
                manyPlayersGameSettingNotifier
                    .updateNumberOfPeople(_manyPlayersNumberOfPeople);
              },
            ),
            const SizedBox(height: 38),
            adjust(
              text: AppText.allottedTime,
              numberText: AppText.tenMinutes,
              items: _manyPlayersWaitTimeItems,
              selectedItem: _manyPlayersWaitTime,
              onChanged: (value) {
                setState(() {
                  _manyPlayersWaitTime = value!;
                });
                manyPlayersGameSettingNotifier
                    .updateWaitTime(_manyPlayersWaitTime);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget twoPlayers(BattleNumber battleNumber) {
    final twoPlayersGameSettingNotifier =
        ref.read(twoPlayersGameSettingProvider.notifier);
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
            adjust(
                text: AppText.allottedTime,
                numberText: AppText.tenMinutes,
                items: _twoPlayersWaitTimeItems,
                selectedItem: _twoPlayersSelectItem,
                onChanged: (value) {
                  setState(() {
                    _twoPlayersSelectItem = value!;
                  });
                  twoPlayersGameSettingNotifier
                      .updateWaitName(_twoPlayersSelectItem);
                }),
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

  Widget adjust(
      {required String text,
      required String numberText,
      required List<DropdownMenuItem<String>> items,
      required String selectedItem,
      required void Function(String?) onChanged}) {
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
          items: items,
          value: selectedItem,
          onChanged: onChanged,
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

  void setWaitTimeItems(List<DropdownMenuItem<String>> items) {
    items
      ..add(
        const DropdownMenuItem(
          value: AppText.tenMinutes,
          child: Text(
            AppText.tenMinutes,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w400,
              color: AppColor.textColorBlack,
            ),
          ),
        ),
      )
      ..add(const DropdownMenuItem(
        value: AppText.thirtyMinutes,
        child: Text(
          AppText.thirtyMinutes,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w400,
            color: AppColor.textColorBlack,
          ),
        ),
      ))
      ..add(const DropdownMenuItem(
        value: AppText.oneHour,
        child: Text(
          AppText.oneHour,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w400,
            color: AppColor.textColorBlack,
          ),
        ),
      ))
      ..add(const DropdownMenuItem(
        value: AppText.twoHours,
        child: Text(
          AppText.twoHours,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w400,
            color: AppColor.textColorBlack,
          ),
        ),
      ))
      ..add(const DropdownMenuItem(
        value: AppText.fourHours,
        child: Text(
          AppText.fourHours,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w400,
            color: AppColor.textColorBlack,
          ),
        ),
      ));
  }

  void setNumberOfPeopleItems() {
    _manyPlayersNumberOfPeopleItems
      ..add(
        const DropdownMenuItem(
          value: AppText.threePeople,
          child: Text(
            AppText.threePeople,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w400,
              color: AppColor.textColorBlack,
            ),
          ),
        ),
      )
      ..add(
        const DropdownMenuItem(
          value: AppText.fourPeople,
          child: Text(
            AppText.fourPeople,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w400,
              color: AppColor.textColorBlack,
            ),
          ),
        ),
      )
      ..add(
        const DropdownMenuItem(
          value: AppText.fivePeople,
          child: Text(
            AppText.fivePeople,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w400,
              color: AppColor.textColorBlack,
            ),
          ),
        ),
      )
      ..add(
        const DropdownMenuItem(
          value: AppText.sixPeople,
          child: Text(
            AppText.sixPeople,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w400,
              color: AppColor.textColorBlack,
            ),
          ),
        ),
      )
      ..add(
        const DropdownMenuItem(
          value: AppText.sevenPeople,
          child: Text(
            AppText.sevenPeople,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w400,
              color: AppColor.textColorBlack,
            ),
          ),
        ),
      )
      ..add(
        const DropdownMenuItem(
          value: AppText.eightPeople,
          child: Text(
            AppText.eightPeople,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w400,
              color: AppColor.textColorBlack,
            ),
          ),
        ),
      );
  }
}
