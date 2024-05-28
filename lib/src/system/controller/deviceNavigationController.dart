import 'dart:async';

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

  final String deviceBackgroundImage;

  /// [_currentAppOpen] is a string that holds the current application that is open.
  String _currentAppOpen = "";

  /// [DeviceNavigationController] is a factory constructor that creates an instance of [DeviceNavigationController].
  factory DeviceNavigationController(
      {required List<DeviceApplication> apps,
      List<DeviceApplication> bottomApps = const [],
      required String deviceBackgroundImage}) {
    return DeviceNavigationController._internal(
        apps: apps,
        bottomApps: bottomApps,
        deviceBackgroundImage: deviceBackgroundImage);
  }

  /// [DeviceNavigationController] is a private constructor that creates an instance of [DeviceNavigationController].
  DeviceNavigationController._internal(
      {required this.apps,
      this.bottomApps = const [],
      required this.deviceBackgroundImage});

  /// [stateChangeStream] is a stream that listens to the state changes in the [DeviceNavigationController].
  Stream<DeviceNavigationControllerState> get stateChangeStream =>
      _stateChangeStreamController.stream;
  final _stateChangeStreamController =
      StreamController<DeviceNavigationControllerState>.broadcast();

  /// [stateChange] is a method that adds the state change to the stream.
  void stateChange(DeviceNavigationControllerState state) {
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
    stateChange(state);
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

    stateChange(state);
  }

  /// [goBackToRoot] is a method that navigates back to the root widget.
  void goBackToRoot() {
    if (_applicationsStates[_currentAppOpen] == null ||
        _applicationsStates[_currentAppOpen]!.isEmpty) {
      _applicationsStates[_currentAppOpen] = [];
    } else {
      _applicationsStates[_currentAppOpen]!.clear();
    }
    stateChange(DeviceNavigationControllerState.goBackToRoot);
  }

  /// [getCurrentApp] is a method that returns the current application that is open.
  Widget getCurrentApp() {
    if (_applicationsStates[_currentAppOpen] == null ||
        _applicationsStates[_currentAppOpen]!.isEmpty) {
      return const SizedBox.shrink();
    }
    return _applicationsStates[_currentAppOpen]!.last;
  }
}
