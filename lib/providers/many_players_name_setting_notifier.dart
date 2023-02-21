import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shogi_game/models/many_players_name_setting.dart';

final manyPlayersNameSettingProvider = StateNotifierProvider<
    ManyPlayersNameSettingNotifier, ManyPlayersNameSetting>((ref) {
  return ManyPlayersNameSettingNotifier();
});

class ManyPlayersNameSettingNotifier
    extends StateNotifier<ManyPlayersNameSetting> {
  ManyPlayersNameSettingNotifier() : super(const ManyPlayersNameSetting());

  void updateName(int index, String name) {
    if (index == 0) {
      state = state.copyWith(name1: name);
    } else if (index == 1) {
      state = state.copyWith(name2: name);
    } else if (index == 2) {
      state = state.copyWith(name3: name);
    } else if (index == 3) {
      state = state.copyWith(name4: name);
    } else if (index == 4) {
      state = state.copyWith(name5: name);
    } else if (index == 5) {
      state = state.copyWith(name6: name);
    } else if (index == 6) {
      state = state.copyWith(name7: name);
    } else {
      state = state.copyWith(name8: name);
    }
  }
}
