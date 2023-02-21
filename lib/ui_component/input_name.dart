import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shogi_game/constraints/app_color.dart';
import 'package:shogi_game/constraints/app_text.dart';
import 'package:shogi_game/pages/top_page.dart';
import 'package:shogi_game/providers/many_players_name_setting_notifier.dart';
import 'package:shogi_game/providers/one_player_game_setting_notifier.dart';
import 'package:shogi_game/providers/two_player_game_setting_notifier.dart';

class InputName extends ConsumerWidget {
  final TextEditingController controller;
  final bool? isFirstMove;
  final BattleNumber battleNumber;
  final int? index;
  const InputName(
      {Key? key,
      required this.controller,
      this.isFirstMove,
      required this.battleNumber,
      this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            onSubmitted: (value) {
              if (battleNumber == BattleNumber.onePlayer) {
                final onePlayerGameSettingNotifier =
                    ref.read(onePlayerGameSettingProvider.notifier);
                onePlayerGameSettingNotifier.updateName(controller.text);
              } else if (battleNumber == BattleNumber.twoPlayers) {
                if (isFirstMove!) {
                  final twoPlayersGameSettingNotifier =
                      ref.read(twoPlayersGameSettingProvider.notifier);
                  twoPlayersGameSettingNotifier
                      .updateFirstMoveName(controller.text);
                } else {
                  final twoPlayersGameSettingNotifier =
                      ref.read(twoPlayersGameSettingProvider.notifier);
                  twoPlayersGameSettingNotifier
                      .updateSecondMoveName(controller.text);
                }
              } else {
                final manyPlayersNameSettingNotifier =
                    ref.read(manyPlayersNameSettingProvider.notifier);
                manyPlayersNameSettingNotifier.updateNameList(
                    controller.text, index!);
              }
            },
          ),
        ),
      ],
    );
  }
}
