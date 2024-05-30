import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class IOSToast {
  /// [toastDecoration] is a decoration that holds the style of the toast.
  Decoration? toastDecoration;

  /// [autoDismiss] is a boolean that holds the state of the toast.
  bool autoDismiss;

  /// [duration] is a duration that holds the time the toast is shown.
  Duration? duration;

  /// [showToast] is a ValueNotifier that holds the state of the toast.
  final showToast = ValueNotifier<bool>(false);

  Widget? leading;

  Widget? content;

  Widget? title;

  Widget? trailing;

  /// [IOSToast] is a constructor that creates an instance of [IOSToast].
  IOSToast({
    this.toastDecoration,
    this.autoDismiss = true,
    this.duration = const Duration(seconds: 2),
  });
}
