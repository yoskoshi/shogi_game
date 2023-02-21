import 'package:freezed_annotation/freezed_annotation.dart';

part 'many_players_name_setting.freezed.dart';

@freezed
class ManyPlayersNameSetting with _$ManyPlayersNameSetting {
  const factory ManyPlayersNameSetting({
    @Default("") String name1,
    @Default("") String name2,
    @Default("") String name3,
    @Default("") String name4,
    @Default("") String name5,
    @Default("") String name6,
    @Default("") String name7,
    @Default("") String name8,
  }) = _ManyPlayersNameSetting;
}
