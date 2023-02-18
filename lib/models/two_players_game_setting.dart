import 'package:freezed_annotation/freezed_annotation.dart';

part 'two_players_game_setting.freezed.dart';

@freezed
class TwoPlayersGameSetting with _$TwoPlayersGameSetting {
  const factory TwoPlayersGameSetting({
    @Default("") String firstMoveName,
    @Default("") String secondMoveName,
    @Default("") String waitTime,
  }) = _TwoPlayersGameSetting;
}
