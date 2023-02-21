import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shogi_game/models/many_players_name_setting.dart';

final manyPlayersNameSettingProvider = StateNotifierProvider<
    ManyPlayersNameSettingNotifier, ManyPlayersNameSetting>((ref) {
  return ManyPlayersNameSettingNotifier();
});

class ManyPlayersNameSettingNotifier
    extends StateNotifier<ManyPlayersNameSetting> {
  ManyPlayersNameSettingNotifier() : super(const ManyPlayersNameSetting());

  void updateNameList(String name, int index) {
    state.nameList[index] = name;
    state = state.copyWith(nameList: state.nameList);
  }
}
