import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shogi_game/constraints/app_color.dart';
import 'package:shogi_game/constraints/app_text.dart';
import 'package:shogi_game/providers/one_player_game_setting_notifier.dart';

class InputName extends ConsumerWidget {
  final TextEditingController controller;
  const InputName({Key? key, required this.controller}) : super(key: key);

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
              final onePlayerGameSettingNotifier =
                  ref.read(onePlayerGameSettingProvider.notifier);
              onePlayerGameSettingNotifier.updateName(controller.text);
            },
          ),
        ),
      ],
    );
  }
}
