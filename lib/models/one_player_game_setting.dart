import 'package:freezed_annotation/freezed_annotation.dart';

part 'one_player_game_setting.freezed.dart';

@freezed
class OnePlayerGameSetting with _$OnePlayerGameSetting {
  const factory OnePlayerGameSetting({
    @Default(true) bool isFirstMove,
    @Default("") String name,
  }) = _OnePlayerGameSetting;
}
