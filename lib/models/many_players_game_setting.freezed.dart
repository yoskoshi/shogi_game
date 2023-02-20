// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'many_players_game_setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ManyPlayersGameSetting {
  String get numberOfPeople => throw _privateConstructorUsedError;
  String get waitTime => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ManyPlayersGameSettingCopyWith<ManyPlayersGameSetting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ManyPlayersGameSettingCopyWith<$Res> {
  factory $ManyPlayersGameSettingCopyWith(ManyPlayersGameSetting value,
          $Res Function(ManyPlayersGameSetting) then) =
      _$ManyPlayersGameSettingCopyWithImpl<$Res, ManyPlayersGameSetting>;
  @useResult
  $Res call({String numberOfPeople, String waitTime});
}

/// @nodoc
class _$ManyPlayersGameSettingCopyWithImpl<$Res,
        $Val extends ManyPlayersGameSetting>
    implements $ManyPlayersGameSettingCopyWith<$Res> {
  _$ManyPlayersGameSettingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? numberOfPeople = null,
    Object? waitTime = null,
  }) {
    return _then(_value.copyWith(
      numberOfPeople: null == numberOfPeople
          ? _value.numberOfPeople
          : numberOfPeople // ignore: cast_nullable_to_non_nullable
              as String,
      waitTime: null == waitTime
          ? _value.waitTime
          : waitTime // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ManyPlayersGameSettingCopyWith<$Res>
    implements $ManyPlayersGameSettingCopyWith<$Res> {
  factory _$$_ManyPlayersGameSettingCopyWith(_$_ManyPlayersGameSetting value,
          $Res Function(_$_ManyPlayersGameSetting) then) =
      __$$_ManyPlayersGameSettingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String numberOfPeople, String waitTime});
}

/// @nodoc
class __$$_ManyPlayersGameSettingCopyWithImpl<$Res>
    extends _$ManyPlayersGameSettingCopyWithImpl<$Res,
        _$_ManyPlayersGameSetting>
    implements _$$_ManyPlayersGameSettingCopyWith<$Res> {
  __$$_ManyPlayersGameSettingCopyWithImpl(_$_ManyPlayersGameSetting _value,
      $Res Function(_$_ManyPlayersGameSetting) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? numberOfPeople = null,
    Object? waitTime = null,
  }) {
    return _then(_$_ManyPlayersGameSetting(
      numberOfPeople: null == numberOfPeople
          ? _value.numberOfPeople
          : numberOfPeople // ignore: cast_nullable_to_non_nullable
              as String,
      waitTime: null == waitTime
          ? _value.waitTime
          : waitTime // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ManyPlayersGameSetting implements _ManyPlayersGameSetting {
  const _$_ManyPlayersGameSetting(
      {this.numberOfPeople = "3人", this.waitTime = "10分"});

  @override
  @JsonKey()
  final String numberOfPeople;
  @override
  @JsonKey()
  final String waitTime;

  @override
  String toString() {
    return 'ManyPlayersGameSetting(numberOfPeople: $numberOfPeople, waitTime: $waitTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ManyPlayersGameSetting &&
            (identical(other.numberOfPeople, numberOfPeople) ||
                other.numberOfPeople == numberOfPeople) &&
            (identical(other.waitTime, waitTime) ||
                other.waitTime == waitTime));
  }

  @override
  int get hashCode => Object.hash(runtimeType, numberOfPeople, waitTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ManyPlayersGameSettingCopyWith<_$_ManyPlayersGameSetting> get copyWith =>
      __$$_ManyPlayersGameSettingCopyWithImpl<_$_ManyPlayersGameSetting>(
          this, _$identity);
}

abstract class _ManyPlayersGameSetting implements ManyPlayersGameSetting {
  const factory _ManyPlayersGameSetting(
      {final String numberOfPeople,
      final String waitTime}) = _$_ManyPlayersGameSetting;

  @override
  String get numberOfPeople;
  @override
  String get waitTime;
  @override
  @JsonKey(ignore: true)
  _$$_ManyPlayersGameSettingCopyWith<_$_ManyPlayersGameSetting> get copyWith =>
      throw _privateConstructorUsedError;
}
