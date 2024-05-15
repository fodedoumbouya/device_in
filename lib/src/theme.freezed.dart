// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DeviceInThemeStyle {
  DeviceInKeyboardStyle get keyboardStyle => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DeviceInThemeStyleCopyWith<DeviceInThemeStyle> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceInThemeStyleCopyWith<$Res> {
  factory $DeviceInThemeStyleCopyWith(
          DeviceInThemeStyle value, $Res Function(DeviceInThemeStyle) then) =
      _$DeviceInThemeStyleCopyWithImpl<$Res, DeviceInThemeStyle>;
  @useResult
  $Res call({DeviceInKeyboardStyle keyboardStyle});

  $DeviceInKeyboardStyleCopyWith<$Res> get keyboardStyle;
}

/// @nodoc
class _$DeviceInThemeStyleCopyWithImpl<$Res, $Val extends DeviceInThemeStyle>
    implements $DeviceInThemeStyleCopyWith<$Res> {
  _$DeviceInThemeStyleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? keyboardStyle = null,
  }) {
    return _then(_value.copyWith(
      keyboardStyle: null == keyboardStyle
          ? _value.keyboardStyle
          : keyboardStyle // ignore: cast_nullable_to_non_nullable
              as DeviceInKeyboardStyle,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DeviceInKeyboardStyleCopyWith<$Res> get keyboardStyle {
    return $DeviceInKeyboardStyleCopyWith<$Res>(_value.keyboardStyle, (value) {
      return _then(_value.copyWith(keyboardStyle: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DeviceInThemeStyleImplCopyWith<$Res>
    implements $DeviceInThemeStyleCopyWith<$Res> {
  factory _$$DeviceInThemeStyleImplCopyWith(_$DeviceInThemeStyleImpl value,
          $Res Function(_$DeviceInThemeStyleImpl) then) =
      __$$DeviceInThemeStyleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DeviceInKeyboardStyle keyboardStyle});

  @override
  $DeviceInKeyboardStyleCopyWith<$Res> get keyboardStyle;
}

/// @nodoc
class __$$DeviceInThemeStyleImplCopyWithImpl<$Res>
    extends _$DeviceInThemeStyleCopyWithImpl<$Res, _$DeviceInThemeStyleImpl>
    implements _$$DeviceInThemeStyleImplCopyWith<$Res> {
  __$$DeviceInThemeStyleImplCopyWithImpl(_$DeviceInThemeStyleImpl _value,
      $Res Function(_$DeviceInThemeStyleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? keyboardStyle = null,
  }) {
    return _then(_$DeviceInThemeStyleImpl(
      keyboardStyle: null == keyboardStyle
          ? _value.keyboardStyle
          : keyboardStyle // ignore: cast_nullable_to_non_nullable
              as DeviceInKeyboardStyle,
    ));
  }
}

/// @nodoc

class _$DeviceInThemeStyleImpl
    with DiagnosticableTreeMixin
    implements _DeviceInThemeStyle {
  const _$DeviceInThemeStyleImpl({required this.keyboardStyle});

  @override
  final DeviceInKeyboardStyle keyboardStyle;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DeviceInThemeStyle(keyboardStyle: $keyboardStyle)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DeviceInThemeStyle'))
      ..add(DiagnosticsProperty('keyboardStyle', keyboardStyle));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceInThemeStyleImpl &&
            (identical(other.keyboardStyle, keyboardStyle) ||
                other.keyboardStyle == keyboardStyle));
  }

  @override
  int get hashCode => Object.hash(runtimeType, keyboardStyle);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeviceInThemeStyleImplCopyWith<_$DeviceInThemeStyleImpl> get copyWith =>
      __$$DeviceInThemeStyleImplCopyWithImpl<_$DeviceInThemeStyleImpl>(
          this, _$identity);
}

abstract class _DeviceInThemeStyle implements DeviceInThemeStyle {
  const factory _DeviceInThemeStyle(
          {required final DeviceInKeyboardStyle keyboardStyle}) =
      _$DeviceInThemeStyleImpl;

  @override
  DeviceInKeyboardStyle get keyboardStyle;
  @override
  @JsonKey(ignore: true)
  _$$DeviceInThemeStyleImplCopyWith<_$DeviceInThemeStyleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DeviceInKeyboardStyle {
  Color get backgroundColor => throw _privateConstructorUsedError;
  Color get button1BackgroundColor => throw _privateConstructorUsedError;
  Color get button1ForegroundColor => throw _privateConstructorUsedError;
  Color get button2BackgroundColor => throw _privateConstructorUsedError;
  Color get button2ForegroundColor => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DeviceInKeyboardStyleCopyWith<DeviceInKeyboardStyle> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceInKeyboardStyleCopyWith<$Res> {
  factory $DeviceInKeyboardStyleCopyWith(DeviceInKeyboardStyle value,
          $Res Function(DeviceInKeyboardStyle) then) =
      _$DeviceInKeyboardStyleCopyWithImpl<$Res, DeviceInKeyboardStyle>;
  @useResult
  $Res call(
      {Color backgroundColor,
      Color button1BackgroundColor,
      Color button1ForegroundColor,
      Color button2BackgroundColor,
      Color button2ForegroundColor});
}

/// @nodoc
class _$DeviceInKeyboardStyleCopyWithImpl<$Res,
        $Val extends DeviceInKeyboardStyle>
    implements $DeviceInKeyboardStyleCopyWith<$Res> {
  _$DeviceInKeyboardStyleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backgroundColor = null,
    Object? button1BackgroundColor = null,
    Object? button1ForegroundColor = null,
    Object? button2BackgroundColor = null,
    Object? button2ForegroundColor = null,
  }) {
    return _then(_value.copyWith(
      backgroundColor: null == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as Color,
      button1BackgroundColor: null == button1BackgroundColor
          ? _value.button1BackgroundColor
          : button1BackgroundColor // ignore: cast_nullable_to_non_nullable
              as Color,
      button1ForegroundColor: null == button1ForegroundColor
          ? _value.button1ForegroundColor
          : button1ForegroundColor // ignore: cast_nullable_to_non_nullable
              as Color,
      button2BackgroundColor: null == button2BackgroundColor
          ? _value.button2BackgroundColor
          : button2BackgroundColor // ignore: cast_nullable_to_non_nullable
              as Color,
      button2ForegroundColor: null == button2ForegroundColor
          ? _value.button2ForegroundColor
          : button2ForegroundColor // ignore: cast_nullable_to_non_nullable
              as Color,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeviceInKeyboardStyleImplCopyWith<$Res>
    implements $DeviceInKeyboardStyleCopyWith<$Res> {
  factory _$$DeviceInKeyboardStyleImplCopyWith(
          _$DeviceInKeyboardStyleImpl value,
          $Res Function(_$DeviceInKeyboardStyleImpl) then) =
      __$$DeviceInKeyboardStyleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Color backgroundColor,
      Color button1BackgroundColor,
      Color button1ForegroundColor,
      Color button2BackgroundColor,
      Color button2ForegroundColor});
}

/// @nodoc
class __$$DeviceInKeyboardStyleImplCopyWithImpl<$Res>
    extends _$DeviceInKeyboardStyleCopyWithImpl<$Res,
        _$DeviceInKeyboardStyleImpl>
    implements _$$DeviceInKeyboardStyleImplCopyWith<$Res> {
  __$$DeviceInKeyboardStyleImplCopyWithImpl(_$DeviceInKeyboardStyleImpl _value,
      $Res Function(_$DeviceInKeyboardStyleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backgroundColor = null,
    Object? button1BackgroundColor = null,
    Object? button1ForegroundColor = null,
    Object? button2BackgroundColor = null,
    Object? button2ForegroundColor = null,
  }) {
    return _then(_$DeviceInKeyboardStyleImpl(
      backgroundColor: null == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as Color,
      button1BackgroundColor: null == button1BackgroundColor
          ? _value.button1BackgroundColor
          : button1BackgroundColor // ignore: cast_nullable_to_non_nullable
              as Color,
      button1ForegroundColor: null == button1ForegroundColor
          ? _value.button1ForegroundColor
          : button1ForegroundColor // ignore: cast_nullable_to_non_nullable
              as Color,
      button2BackgroundColor: null == button2BackgroundColor
          ? _value.button2BackgroundColor
          : button2BackgroundColor // ignore: cast_nullable_to_non_nullable
              as Color,
      button2ForegroundColor: null == button2ForegroundColor
          ? _value.button2ForegroundColor
          : button2ForegroundColor // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// @nodoc

class _$DeviceInKeyboardStyleImpl
    with DiagnosticableTreeMixin
    implements _DeviceInKeyboardStyle {
  const _$DeviceInKeyboardStyleImpl(
      {required this.backgroundColor,
      required this.button1BackgroundColor,
      required this.button1ForegroundColor,
      required this.button2BackgroundColor,
      required this.button2ForegroundColor});

  @override
  final Color backgroundColor;
  @override
  final Color button1BackgroundColor;
  @override
  final Color button1ForegroundColor;
  @override
  final Color button2BackgroundColor;
  @override
  final Color button2ForegroundColor;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DeviceInKeyboardStyle(backgroundColor: $backgroundColor, button1BackgroundColor: $button1BackgroundColor, button1ForegroundColor: $button1ForegroundColor, button2BackgroundColor: $button2BackgroundColor, button2ForegroundColor: $button2ForegroundColor)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DeviceInKeyboardStyle'))
      ..add(DiagnosticsProperty('backgroundColor', backgroundColor))
      ..add(
          DiagnosticsProperty('button1BackgroundColor', button1BackgroundColor))
      ..add(
          DiagnosticsProperty('button1ForegroundColor', button1ForegroundColor))
      ..add(
          DiagnosticsProperty('button2BackgroundColor', button2BackgroundColor))
      ..add(DiagnosticsProperty(
          'button2ForegroundColor', button2ForegroundColor));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceInKeyboardStyleImpl &&
            (identical(other.backgroundColor, backgroundColor) ||
                other.backgroundColor == backgroundColor) &&
            (identical(other.button1BackgroundColor, button1BackgroundColor) ||
                other.button1BackgroundColor == button1BackgroundColor) &&
            (identical(other.button1ForegroundColor, button1ForegroundColor) ||
                other.button1ForegroundColor == button1ForegroundColor) &&
            (identical(other.button2BackgroundColor, button2BackgroundColor) ||
                other.button2BackgroundColor == button2BackgroundColor) &&
            (identical(other.button2ForegroundColor, button2ForegroundColor) ||
                other.button2ForegroundColor == button2ForegroundColor));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      backgroundColor,
      button1BackgroundColor,
      button1ForegroundColor,
      button2BackgroundColor,
      button2ForegroundColor);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeviceInKeyboardStyleImplCopyWith<_$DeviceInKeyboardStyleImpl>
      get copyWith => __$$DeviceInKeyboardStyleImplCopyWithImpl<
          _$DeviceInKeyboardStyleImpl>(this, _$identity);
}

abstract class _DeviceInKeyboardStyle implements DeviceInKeyboardStyle {
  const factory _DeviceInKeyboardStyle(
          {required final Color backgroundColor,
          required final Color button1BackgroundColor,
          required final Color button1ForegroundColor,
          required final Color button2BackgroundColor,
          required final Color button2ForegroundColor}) =
      _$DeviceInKeyboardStyleImpl;

  @override
  Color get backgroundColor;
  @override
  Color get button1BackgroundColor;
  @override
  Color get button1ForegroundColor;
  @override
  Color get button2BackgroundColor;
  @override
  Color get button2ForegroundColor;
  @override
  @JsonKey(ignore: true)
  _$$DeviceInKeyboardStyleImplCopyWith<_$DeviceInKeyboardStyleImpl>
      get copyWith => throw _privateConstructorUsedError;
}
