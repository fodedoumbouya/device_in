import 'package:flutter/material.dart';

class AppWidgetBox extends StatelessWidget {
  /// [iconPath] is a string that holds the path to the icon of the application.
  /// supports "assets/images/icon.png" format or "http".
  final String? iconPath;

  /// [iconCustomWidget] is a widget that holds the custom icon of the application.
  final Widget? iconCustomWidget;

  /// [appName] is a string that holds the name of the application.
  final String? appName;

  /// [appNameStyle] is a TextStyle that holds the style of the application name.
  /// Default is TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500).
  final TextStyle? appNameStyle;

  /// [onTapDown] is a function that is called when the user taps down on the application.
  final void Function(TapDownDetails)? onTapDown;

  const AppWidgetBox(
      {this.appName,
      this.iconPath,
      this.iconCustomWidget,
      this.appNameStyle,
      this.onTapDown,
      super.key})
      : assert(iconPath != null || iconCustomWidget != null,
            "iconPath and iconCustomWidget can't be null at the same time");

  @override
  Widget build(BuildContext context) {
    final Widget widgetView = iconCustomWidget ??
        Image.asset(
          iconPath!,
          fit: BoxFit.contain,
        );
    return GestureDetector(
      onTapDown: onTapDown,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ]),
                child: widgetView,
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          if (appName != null)
            Text(
              appName!,
              style: appNameStyle ??
                  const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
            ),
        ],
      ),
    );
  }
}
