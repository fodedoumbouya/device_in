import 'package:device_in/src/utils/deviceInfo.dart';
import 'package:device_in/src/devices/ios/iphone_13_pro_max/device.dart'
    as i_iphone_13_pro_max;

/// A list of common iOS device specifications.
/// example:
/// ```dart
/// Devices.ios.iPhone13ProMax
/// ```
class IosDevices {
  /// A list of common iOS device specifications.
  const IosDevices();

  /// iPhone 13 Pro Max.
  DeviceInfo get iPhone13ProMax => i_iphone_13_pro_max.info;

  /// All devices.
  List<DeviceInfo> get all => [
        iPhone13ProMax,
      ];
}
