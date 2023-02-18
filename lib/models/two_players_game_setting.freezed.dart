// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'two_players_game_setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TwoPlayersGameSetting {
  String get firstMoveName => throw _privateConstructorUsedError;
  String get secondMoveName => throw _privateConstructorUsedError;
  String get waitTime => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TwoPlayersGameSettingCopyWith<TwoPlayersGameSetting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TwoPlayersGameSettingCopyWith<$Res> {
  factory $TwoPlayersGameSettingCopyWith(TwoPlayersGameSetting value,
          $Res Function(TwoPlayersGameSetting) then) =
      _$TwoPlayersGameSettingCopyWithImpl<$Res, TwoPlayersGameSetting>;
  @useResult
  $Res call({String firstMoveName, String secondMoveName, String waitTime});
}

/// @nodoc
class _$TwoPlayersGameSettingCopyWithImpl<$Res,
        $Val extends TwoPlayersGameSetting>
    implements $TwoPlayersGameSettingCopyWith<$Res> {
  _$TwoPlayersGameSettingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstMoveName = null,
    Object? secondMoveName = null,
    Object? waitTime = null,
  }) {
    return _then(_value.copyWith(
      firstMoveName: null == firstMoveName
          ? _value.firstMoveName
          : firstMoveName // ignore: cast_nullable_to_non_nullable
              as String,
      secondMoveName: null == secondMoveName
          ? _value.secondMoveName
          : secondMoveName // ignore: cast_nullable_to_non_nullable
              as String,
      waitTime: null == waitTime
          ? _value.waitTime
          : waitTime // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TwoPlayersGameSettingCopyWith<$Res>
    implements $TwoPlayersGameSettingCopyWith<$Res> {
  factory _$$_TwoPlayersGameSettingCopyWith(_$_TwoPlayersGameSetting value,
          $Res Function(_$_TwoPlayersGameSetting) then) =
      __$$_TwoPlayersGameSettingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String firstMoveName, String secondMoveName, String waitTime});
}

/// @nodoc
class __$$_TwoPlayersGameSettingCopyWithImpl<$Res>
    extends _$TwoPlayersGameSettingCopyWithImpl<$Res, _$_TwoPlayersGameSetting>
    implements _$$_TwoPlayersGameSettingCopyWith<$Res> {
  __$$_TwoPlayersGameSettingCopyWithImpl(_$_TwoPlayersGameSetting _value,
      $Res Function(_$_TwoPlayersGameSetting) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstMoveName = null,
    Object? secondMoveName = null,
    Object? waitTime = null,
  }) {
    return _then(_$_TwoPlayersGameSetting(
      firstMoveName: null == firstMoveName
          ? _value.firstMoveName
          : firstMoveName // ignore: cast_nullable_to_non_nullable
              as String,
      secondMoveName: null == secondMoveName
          ? _value.secondMoveName
          : secondMoveName // ignore: cast_nullable_to_non_nullable
              as String,
      waitTime: null == waitTime
          ? _value.waitTime
          : waitTime // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_TwoPlayersGameSetting implements _TwoPlayersGameSetting {
  const _$_TwoPlayersGameSetting(
      {this.firstMoveName = "", this.secondMoveName = "", this.waitTime = ""});

  @override
  @JsonKey()
  final String firstMoveName;
  @override
  @JsonKey()
  final String secondMoveName;
  @override
  @JsonKey()
  final String waitTime;

  @override
  String toString() {
    return 'TwoPlayersGameSetting(firstMoveName: $firstMoveName, secondMoveName: $secondMoveName, waitTime: $waitTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TwoPlayersGameSetting &&
            (identical(other.firstMoveName, firstMoveName) ||
                other.firstMoveName == firstMoveName) &&
            (identical(other.secondMoveName, secondMoveName) ||
                other.secondMoveName == secondMoveName) &&
            (identical(other.waitTime, waitTime) ||
                other.waitTime == waitTime));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, firstMoveName, secondMoveName, waitTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TwoPlayersGameSettingCopyWith<_$_TwoPlayersGameSetting> get copyWith =>
      __$$_TwoPlayersGameSettingCopyWithImpl<_$_TwoPlayersGameSetting>(
          this, _$identity);
}

abstract class _TwoPlayersGameSetting implements TwoPlayersGameSetting {
  const factory _TwoPlayersGameSetting(
      {final String firstMoveName,
      final String secondMoveName,
      final String waitTime}) = _$_TwoPlayersGameSetting;

  @override
  String get firstMoveName;
  @override
  String get secondMoveName;
  @override
  String get waitTime;
  @override
  @JsonKey(ignore: true)
  _$$_TwoPlayersGameSettingCopyWith<_$_TwoPlayersGameSetting> get copyWith =>
      throw _privateConstructorUsedError;
}
