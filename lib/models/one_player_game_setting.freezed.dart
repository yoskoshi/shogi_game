// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'one_player_game_setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$OnePlayerGameSetting {
  bool get isFirstMove => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OnePlayerGameSettingCopyWith<OnePlayerGameSetting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnePlayerGameSettingCopyWith<$Res> {
  factory $OnePlayerGameSettingCopyWith(OnePlayerGameSetting value,
          $Res Function(OnePlayerGameSetting) then) =
      _$OnePlayerGameSettingCopyWithImpl<$Res, OnePlayerGameSetting>;
  @useResult
  $Res call({bool isFirstMove, String name});
}

/// @nodoc
class _$OnePlayerGameSettingCopyWithImpl<$Res,
        $Val extends OnePlayerGameSetting>
    implements $OnePlayerGameSettingCopyWith<$Res> {
  _$OnePlayerGameSettingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isFirstMove = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      isFirstMove: null == isFirstMove
          ? _value.isFirstMove
          : isFirstMove // ignore: cast_nullable_to_non_nullable
              as bool,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OnePlayerGameSettingCopyWith<$Res>
    implements $OnePlayerGameSettingCopyWith<$Res> {
  factory _$$_OnePlayerGameSettingCopyWith(_$_OnePlayerGameSetting value,
          $Res Function(_$_OnePlayerGameSetting) then) =
      __$$_OnePlayerGameSettingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isFirstMove, String name});
}

/// @nodoc
class __$$_OnePlayerGameSettingCopyWithImpl<$Res>
    extends _$OnePlayerGameSettingCopyWithImpl<$Res, _$_OnePlayerGameSetting>
    implements _$$_OnePlayerGameSettingCopyWith<$Res> {
  __$$_OnePlayerGameSettingCopyWithImpl(_$_OnePlayerGameSetting _value,
      $Res Function(_$_OnePlayerGameSetting) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isFirstMove = null,
    Object? name = null,
  }) {
    return _then(_$_OnePlayerGameSetting(
      isFirstMove: null == isFirstMove
          ? _value.isFirstMove
          : isFirstMove // ignore: cast_nullable_to_non_nullable
              as bool,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_OnePlayerGameSetting implements _OnePlayerGameSetting {
  const _$_OnePlayerGameSetting({this.isFirstMove = true, this.name = ""});

  @override
  @JsonKey()
  final bool isFirstMove;
  @override
  @JsonKey()
  final String name;

  @override
  String toString() {
    return 'OnePlayerGameSetting(isFirstMove: $isFirstMove, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OnePlayerGameSetting &&
            (identical(other.isFirstMove, isFirstMove) ||
                other.isFirstMove == isFirstMove) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isFirstMove, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OnePlayerGameSettingCopyWith<_$_OnePlayerGameSetting> get copyWith =>
      __$$_OnePlayerGameSettingCopyWithImpl<_$_OnePlayerGameSetting>(
          this, _$identity);
}

abstract class _OnePlayerGameSetting implements OnePlayerGameSetting {
  const factory _OnePlayerGameSetting(
      {final bool isFirstMove, final String name}) = _$_OnePlayerGameSetting;

  @override
  bool get isFirstMove;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_OnePlayerGameSettingCopyWith<_$_OnePlayerGameSetting> get copyWith =>
      throw _privateConstructorUsedError;
}
