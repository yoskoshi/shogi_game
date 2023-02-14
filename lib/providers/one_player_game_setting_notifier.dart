import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shogi_game/models/one_player_game_setting.dart';

final onePlayerGameSettingProvider =
    StateNotifierProvider<OnePlayerGameSettingNotifier, OnePlayerGameSetting>(
        (ref) {
  return OnePlayerGameSettingNotifier();
});

class OnePlayerGameSettingNotifier extends StateNotifier<OnePlayerGameSetting> {
  OnePlayerGameSettingNotifier() : super(const OnePlayerGameSetting());

  void updateFirstMoveOrSecondMove(bool isFirstMove) {
    state = state.copyWith(isFirstMove: isFirstMove);
  }

  void updateName(String name) {
    state = state.copyWith(name: name);
  }
}
