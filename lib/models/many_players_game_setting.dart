import 'package:freezed_annotation/freezed_annotation.dart';

part 'many_players_game_setting.freezed.dart';

@freezed
class ManyPlayersGameSetting with _$ManyPlayersGameSetting {
  const factory ManyPlayersGameSetting({
    @Default("3人") String numberOfPeople,
    @Default("10分") String waitTime,
  }) = _ManyPlayersGameSetting;
}
