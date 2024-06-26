// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'dart:async';

import 'package:device_in/src/system/model/toast.dart';
import 'package:flutter/widgets.dart';

import '../model/enum.dart';
import '../model/deviceApplication.dart';

/// [DeviceNavigationController] is a controller that helps to navigate between different applications
/// and keep track of the current state of the application. It is used to manage the navigation between applications
/// in the IOS system view.
class DeviceNavigationController {
  /// [applicationsStates] is a map that holds the current state of the applications.
  final Map<String, List<Widget>> _applicationsStates = {};

  /// [apps] is a list of applications that are available in the system view.
  final List<DeviceApplication> apps;

  /// [bottomApps] is a list of applications that are available in the system view.
  /// [4 applications are shown in the bottom bar in Max]
  final List<DeviceApplication> bottomApps;

  /// [deviceBackgroundImage] is a string that holds the path to the background image of the device.
  final String deviceBackgroundImage;

  ///[toast] is an instance of [IOSToast].
  IOSToast toast = IOSToast();

  /// [_currentAppOpen] is a string that holds the current application that is open.
  String _currentAppOpen = "";

  /// The flag for showing the Flutter text.
  bool showFlutterText;

  /// [DeviceNavigationController] is a factory constructor that creates an instance of [DeviceNavigationController].
  /// [apps] is a list of applications that are available in the system view.
  /// [bottomApps] is a list of applications that are available on the bottom bar in the system view.
  /// [deviceBackgroundImage] is a string that holds the path to the background image of the device.
  /// ```dart
  /// DeviceNavigationController(
  /// showFlutterText: true,
  ///  apps: [
  ///   DeviceApplication(
  ///    appName: 'Flutter',
  ///   isBigWidget: true,
  ///  appEntry: (controller) {
  ///   return FlutterScreen(controller: controller);
  /// },
  ///   iconImage: 'assets/flutter.png',
  /// ),
  ///   DeviceApplication(
  ///     appName: 'calendar',
  ///      isBigWidget: false,
  ///     appEntry: (controller) {
  ///       return const Center(child: Text('calendar'));
  ///     },
  ///     iconImage: 'assets/calendar.png',
  /// ),
  /// bottomApps: [
  ///   DeviceApplication(
  ///     appName: 'Safari',
  ///     isBigWidget: false,
  ///     appEntry: (controller) {
  ///       return const Center(child: Text('Safari'));
  ///     },
  ///     iconImage: 'assets/safari.png',
  /// ),
  /// ],
  /// deviceBackgroundImage: "assets/iphone_wal.png",
  /// )
  /// ```
  factory DeviceNavigationController({
    required List<DeviceApplication> apps,
    List<DeviceApplication> bottomApps = const [],
    String deviceBackgroundImage = "packages/device_in/assets/iphone_wal.png",
    bool showFlutterText = true,
  }) {
    return DeviceNavigationController._internal(
        apps: apps,
        bottomApps: bottomApps,
        deviceBackgroundImage: deviceBackgroundImage,
        showFlutterText: showFlutterText);
  }

  /// [DeviceNavigationController] is a private constructor that creates an instance of [DeviceNavigationController].
  DeviceNavigationController._internal({
    required this.apps,
    this.bottomApps = const [],
    required this.deviceBackgroundImage,
    required this.showFlutterText,
  });

  /// [stateChangeStream] is a stream that listens to the state changes in the [DeviceNavigationController].
  Stream<DeviceNavigationControllerState> get stateChangeStream =>
      _stateChangeStreamController.stream;
  final _stateChangeStreamController =
      StreamController<DeviceNavigationControllerState>.broadcast();

  /// [stateChange] is a method that adds the state change to the stream.
  void _stateChange(DeviceNavigationControllerState state) {
    _stateChangeStreamController.add(state);
  }

  /// [goTo] is a method that navigates to the given widget.
  void goTo({required Widget widget}) {
    if (_applicationsStates[_currentAppOpen] == null) {
      _currentAppOpen = widget.toStringShallow();
      _applicationsStates[_currentAppOpen] = [];
    }
    DeviceNavigationControllerState state =
        switch (_applicationsStates[_currentAppOpen]!.isEmpty) {
      true => DeviceNavigationControllerState.firstOpen,
      false => DeviceNavigationControllerState.goTo,
    };

    _applicationsStates[_currentAppOpen]!.add(widget);
    _stateChange(state);
  }

  /// [goBack] is a method that navigates back to the previous widget.
  void goBack() {
    if (_applicationsStates[_currentAppOpen] == null ||
        _applicationsStates[_currentAppOpen]!.isEmpty) {
      _applicationsStates[_currentAppOpen] = [];
    } else {
      _applicationsStates[_currentAppOpen]!.removeLast();
    }
    DeviceNavigationControllerState state =
        switch (_applicationsStates[_currentAppOpen]!.isEmpty) {
      true => DeviceNavigationControllerState.goBackToRoot,
      false => DeviceNavigationControllerState.goBack,
    };

    _stateChange(state);
  }

  /// [goBackToRoot] is a method that navigates back to the root widget.
  void goBackToRoot() {
    if (_applicationsStates[_currentAppOpen] == null ||
        _applicationsStates[_currentAppOpen]!.isEmpty) {
      _applicationsStates[_currentAppOpen] = [];
    } else {
      _applicationsStates[_currentAppOpen]!.clear();
    }
    _stateChange(DeviceNavigationControllerState.goBackToRoot);
  }

  /// [getCurrentApp] is a method that returns the current application that is open.
  Widget getCurrentApp() {
    if (_applicationsStates[_currentAppOpen] == null ||
        _applicationsStates[_currentAppOpen]!.isEmpty) {
      return const SizedBox.shrink();
    }
    return _applicationsStates[_currentAppOpen]!.last;
  }

  /// [showToast] is a function that shows a toast.
  void showToast({
    Widget? content,
    Widget? title,
    Widget? leading,
    Widget? trailing,
    Duration? duration,
    Decoration? toastDecoration,
    EdgeInsetsGeometry? contentPadding,
    bool autoDismiss = true,
  }) async {
    if (toast.showToast.value) {
      hideToast();
      await Future.delayed(const Duration(milliseconds: 700));
    }
    toast
      ..content = content
      ..title = title
      ..leading = leading
      ..trailing = trailing
      ..duration = duration
      ..toastDecoration = toastDecoration
      ..autoDismiss = autoDismiss
      ..contentPadding = contentPadding
      ..showToast.value = true;
    toast.showToast.notifyListeners();
    if (autoDismiss) {
      Future.delayed(
          (duration ?? const Duration(seconds: 2)) +
              const Duration(milliseconds: 500), () {
        toast.showToast.value = false;
        toast.showToast.notifyListeners();
      });
    }
  }

  /// [hideToast] is a function that hides the toast.
  void hideToast() {
    if (toast.showToast.value) {
      toast.showToast.value = false;
      toast.showToast.notifyListeners();
    }
  }
}
