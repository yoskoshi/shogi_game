import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shogi_game/models/two_players_game_setting.dart';

final twoPlayersGameSettingProvider =
    StateNotifierProvider<TwoPlayersGameSettingNotifier, TwoPlayersGameSetting>(
        (ref) {
  return TwoPlayersGameSettingNotifier();
});

class TwoPlayersGameSettingNotifier
    extends StateNotifier<TwoPlayersGameSetting> {
  TwoPlayersGameSettingNotifier() : super(const TwoPlayersGameSetting());

  void updateFirstMoveName(String firstMoveName) {
    state = state.copyWith(firstMoveName: firstMoveName);
  }

  void updateSecondMoveName(String secondMoveName) {
    state = state.copyWith(secondMoveName: secondMoveName);
  }

  void updateWaitName(String waitTime) {
    state = state.copyWith(waitTime: waitTime);
  }
}
