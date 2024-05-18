import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DeviceApplication {
  /// [appName] is a string that holds the name of the application.
  final String appName;

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
    required this.appName,
    required this.appEntry,
    this.iconImage,
    this.iconImageWidget,
    this.isBigWidget = false,
  });
}
