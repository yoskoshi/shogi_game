import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shogi_game/models/many_players_game_setting.dart';

final manyPlayersGameSettingProvider = StateNotifierProvider<
    ManyPlayersGameSettingNotifier, ManyPlayersGameSetting>((ref) {
  return ManyPlayersGameSettingNotifier();
});

class ManyPlayersGameSettingNotifier
    extends StateNotifier<ManyPlayersGameSetting> {
  ManyPlayersGameSettingNotifier() : super(const ManyPlayersGameSetting());

  void updateNumberOfPeople(String numberOfPeople) {
    state = state.copyWith(numberOfPeople: numberOfPeople);
  }

  void updateWaitTime(String waitTime) {
    state = state.copyWith(waitTime: waitTime);
  }
}
