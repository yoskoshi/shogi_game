// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'many_players_name_setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ManyPlayersNameSetting {
  List<String> get nameList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ManyPlayersNameSettingCopyWith<ManyPlayersNameSetting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ManyPlayersNameSettingCopyWith<$Res> {
  factory $ManyPlayersNameSettingCopyWith(ManyPlayersNameSetting value,
          $Res Function(ManyPlayersNameSetting) then) =
      _$ManyPlayersNameSettingCopyWithImpl<$Res, ManyPlayersNameSetting>;
  @useResult
  $Res call({List<String> nameList});
}

/// @nodoc
class _$ManyPlayersNameSettingCopyWithImpl<$Res,
        $Val extends ManyPlayersNameSetting>
    implements $ManyPlayersNameSettingCopyWith<$Res> {
  _$ManyPlayersNameSettingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nameList = null,
  }) {
    return _then(_value.copyWith(
      nameList: null == nameList
          ? _value.nameList
          : nameList // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ManyPlayersNameSettingCopyWith<$Res>
    implements $ManyPlayersNameSettingCopyWith<$Res> {
  factory _$$_ManyPlayersNameSettingCopyWith(_$_ManyPlayersNameSetting value,
          $Res Function(_$_ManyPlayersNameSetting) then) =
      __$$_ManyPlayersNameSettingCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> nameList});
}

/// @nodoc
class __$$_ManyPlayersNameSettingCopyWithImpl<$Res>
    extends _$ManyPlayersNameSettingCopyWithImpl<$Res,
        _$_ManyPlayersNameSetting>
    implements _$$_ManyPlayersNameSettingCopyWith<$Res> {
  __$$_ManyPlayersNameSettingCopyWithImpl(_$_ManyPlayersNameSetting _value,
      $Res Function(_$_ManyPlayersNameSetting) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nameList = null,
  }) {
    return _then(_$_ManyPlayersNameSetting(
      nameList: null == nameList
          ? _value._nameList
          : nameList // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$_ManyPlayersNameSetting implements _ManyPlayersNameSetting {
  const _$_ManyPlayersNameSetting(
      {final List<String> nameList = const ["", "", "", "", "", "", "", ""]})
      : _nameList = nameList;

  final List<String> _nameList;
  @override
  @JsonKey()
  List<String> get nameList {
    if (_nameList is EqualUnmodifiableListView) return _nameList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nameList);
  }

  @override
  String toString() {
    return 'ManyPlayersNameSetting(nameList: $nameList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ManyPlayersNameSetting &&
            const DeepCollectionEquality().equals(other._nameList, _nameList));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_nameList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ManyPlayersNameSettingCopyWith<_$_ManyPlayersNameSetting> get copyWith =>
      __$$_ManyPlayersNameSettingCopyWithImpl<_$_ManyPlayersNameSetting>(
          this, _$identity);
}

abstract class _ManyPlayersNameSetting implements ManyPlayersNameSetting {
  const factory _ManyPlayersNameSetting({final List<String> nameList}) =
      _$_ManyPlayersNameSetting;

  @override
  List<String> get nameList;
  @override
  @JsonKey(ignore: true)
  _$$_ManyPlayersNameSettingCopyWith<_$_ManyPlayersNameSetting> get copyWith =>
      throw _privateConstructorUsedError;
}
