import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

  /// [appEntry] is a widget that holds the entry point of the application or the first widget to open on launch.
  final Widget appEntry;

  /// [isBigWidget] is a boolean that holds the state of the widget.
  /// If true, the widget is big, else it is small.
  final bool isBigWidget;
  DeviceApplication({
    this.appName,
    required this.appEntry,
    this.appNameStyle,
    this.iconImage,
    this.iconImageWidget,
    this.isBigWidget = false,
  })  : assert(iconImage != null || iconImageWidget != null,
            "iconImage and iconImageWidget can't be null at the same time"),
        assert(appName == null || iconImage == null || iconImageWidget == null,
            "appName, iconImage and iconImageWidget can't be null at the same time");
}
