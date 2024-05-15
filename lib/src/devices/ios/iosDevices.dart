import 'package:device_in/src/utils/deviceInfo.dart';
import 'package:device_in/src/devices/ios/iphone_13_pro_max/device.dart'
    as i_iphone_13_pro_max;

class IosDevices {
  const IosDevices();

  DeviceInfo get iPhone13ProMax => i_iphone_13_pro_max.info;
  // DeviceInfo get iPhoneSE => i_iphone_se.info;
  // DeviceInfo get iPadAir4 => i_ipad_air_4.info;
  /// All devices.
  List<DeviceInfo> get all => [
        // Phones
        // iPhone12Mini,
        iPhone13ProMax,
      ];
}
