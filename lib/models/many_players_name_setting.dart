import 'package:freezed_annotation/freezed_annotation.dart';

part 'many_players_name_setting.freezed.dart';

@freezed
class ManyPlayersNameSetting with _$ManyPlayersNameSetting {
  const factory ManyPlayersNameSetting({
    @Default(["", "", "", "", "", "", "", ""]) List<String> nameList,
  }) = _ManyPlayersNameSetting;
}
