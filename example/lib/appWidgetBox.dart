import 'package:flutter/material.dart';

class AppWidgetBox extends StatelessWidget {
  final String? iconPath;
  final Widget? iconCustomWidget;
  final String appName;
  final TextStyle? appNameStyle;

  const AppWidgetBox(
      {required this.appName,
      this.iconPath,
      this.iconCustomWidget,
      this.appNameStyle,
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
    return Container(
      ///TODO: test perpose only
      // color: Colors.red,
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
          Text(
            appName,
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
