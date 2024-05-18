import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme.freezed.dart';

/// The theme gives a [style] to all its descentant device frames.
///
/// The only customizable visuals are the keyboard style.
class DeviceInTheme extends InheritedWidget {
  /// Give a [style] to all descentant in [child] device frames.
  const DeviceInTheme({
    super.key,
    required this.style,
    required super.child,
  });

  /// The style of the device frame.
  final DeviceInThemeStyle style;

  /// The data from the closest instance of this class that encloses the given
  /// [context].
  static DeviceInThemeStyle of(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<DeviceInTheme>();

    return widget?.style ?? DeviceInThemeStyle.dark();
  }

  @override
  bool updateShouldNotify(DeviceInTheme oldWidget) {
    return oldWidget.style != style;
  }
}

/// The device frame style only allows to update the [keyboardStyle] for now.
///
/// See also:
///
/// * [DeviceInKeyboardStyle] to customize the virtual on screen keyboard.
@freezed
abstract class DeviceInThemeStyle with _$DeviceInThemeStyle {
  /// Create a [DeviceInThemeStyle] with the given [keyboardStyle].
  const factory DeviceInThemeStyle({
    required DeviceInKeyboardStyle keyboardStyle,
  }) = _DeviceInThemeStyle;

  /// A default dark theme.
  factory DeviceInThemeStyle.dark({DeviceInKeyboardStyle? keyboardStyle}) =>
      DeviceInThemeStyle(
        keyboardStyle: keyboardStyle ?? DeviceInKeyboardStyle.dark(),
      );
}

/// The keyboard style allows to customize the virtual onscreen keyboard visuals.
@freezed
abstract class DeviceInKeyboardStyle with _$DeviceInKeyboardStyle {
  /// Creates a new style for the virtual keyboard.
  const factory DeviceInKeyboardStyle({
    required Color backgroundColor,
    required Color button1BackgroundColor,
    required Color button1ForegroundColor,
    required Color button2BackgroundColor,
    required Color button2ForegroundColor,
  }) = _DeviceInKeyboardStyle;

  /// A default dark theme for the virtual keyboard.
  factory DeviceInKeyboardStyle.dark() => const DeviceInKeyboardStyle(
        backgroundColor: Color(0xDD2B2B2D),
        button1BackgroundColor: Color(0xFF6D6D6E),
        button1ForegroundColor: Colors.white,
        button2BackgroundColor: Color(0xFF4A4A4B),
        button2ForegroundColor: Colors.white,
      );
}
