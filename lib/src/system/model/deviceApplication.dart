import 'package:device_in/device_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// [bottomSheetOffset] - fractional value of offset.
typedef EntryWidgetBuilder = Widget Function(
  DeviceNavigationController controller,
);

class DeviceApplication {
  /// [appName] is a string that holds the name of the application.
  String? appName;

  /// [appNameStyle] is a TextStyle that holds the style of the application name.
  /// Default is TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500).
  final TextStyle? appNameStyle;

  /// [iconImage] is a string that holds the path to the icon of the application.
  /// supports "assets/images/icon.png" format or "http".
  final String? iconImage;

  /// [iconImageWidget] is a widget that holds the custom icon of the application.
  final Widget? iconImageWidget;

  /// [iconImageWidgetIgnoreGesture] is a boolean that holds the state of the widget.
  final bool iconImageWidgetIgnoreGesture;

  /// [appEntry] is a widget that holds the entry point of the application or the first widget to open on launch.
  /// Function(BuildContext, ScrollController, double
  final EntryWidgetBuilder? appEntry;

  /// [onTap] is a function that is called when the application is tapped.
  final void Function()? onTap;

  /// [isBigWidget] is a boolean that holds the state of the widget.
  /// If true, the widget is big, else it is small.
  final bool isBigWidget;
  DeviceApplication({
    this.appName,
    this.appEntry,
    this.onTap,
    this.appNameStyle,
    this.iconImage,
    this.iconImageWidget,
    this.iconImageWidgetIgnoreGesture = false,
    this.isBigWidget = false,
  })  : assert(iconImage != null || iconImageWidget != null,
            "iconImage and iconImageWidget can't be null at the same time"),
        assert(appEntry != null || onTap != null,
            "appEntry and onTap can't be null at the same time"),
        assert(appName == null || iconImage == null || iconImageWidget == null,
            "appName, iconImage and iconImageWidget can't be null at the same time");
}
