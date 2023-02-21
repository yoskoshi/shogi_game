import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shogi_game/providers/many_players_name_setting_notifier.dart';

class ManyPlayersTournamentTablePage extends ConsumerWidget {
  const ManyPlayersTournamentTablePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final manyPlayersNameSetting = ref.watch(manyPlayersNameSettingProvider);
    print(manyPlayersNameSetting.name1);
    print(manyPlayersNameSetting.name2);
    print(manyPlayersNameSetting.name3);
    print(manyPlayersNameSetting.name4);
    print(manyPlayersNameSetting.name5);
    print(manyPlayersNameSetting.name6);
    print(manyPlayersNameSetting.name7);
    print(manyPlayersNameSetting.name8);
    return const Scaffold(
      body: Center(
        child: Text("manyPlayersTournamentTablePage"),
      ),
    );
  }
}
