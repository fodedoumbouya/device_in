import 'dart:ui';

import 'package:device_in/src/devices/ios/iosDevices.dart';
import 'package:device_in/src/utils/deviceInfo.dart';

/// A list of common device specifications sorted by target platform.
class Devices {
  Size windowSize;
  Devices({required this.windowSize});

  /// All iOS devices.
  static const ios = IosDevices();

  /// future implementation

  /// All macOS devices.
  // static const macOS = MacOSDevices();

  /// future implementation
  // getOnlyMac() {
  //   return MacOSDevices(windowSize: windowSize).macbook;
  // }

  /// future implementation
  // getOnlyIphone() {
  //   return ios.iPhone13ProMax;
  // }

  /// All available devices.
  static List<DeviceInfo> get all => [
        ...ios.all,
        // ...android.all,
      ];
}
