import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:iphone_preview/src/desktop_monitor/device.dart';

import 'identifier.dart';

part 'deviceInfo.freezed.dart';

/// Info about a device and its frame.
@freezed
abstract class DeviceInfo with _$DeviceInfo {
  /// Create a new device info.
  const factory DeviceInfo({
    /// Identifier of the device.
    required DeviceIdentifier identifier,

    /// The display name of the device.
    required String name,

    /// The safe areas when the device is in landscape orientation.
    @Default(null) EdgeInsets? rotatedSafeAreas,

    /// The safe areas when the device is in portrait orientation.
    required EdgeInsets safeAreas,

    /// A shape representing the screen.
    required Path screenPath,

    /// The screen pixel density of the device.
    required double pixelRatio,

    /// The safe areas when the device is in portrait orientation.
    required CustomPainter framePainter,

    /// The frame size in pixels.
    required Size frameSize,

    /// The size in points of the screen content.
    required Size screenSize,
  }) = _DeviceInfo;
}

extension DeviceInfoExtension on DeviceInfo {
  /// Indicates whether the device can rotate.
  bool get canRotate => rotatedSafeAreas != null;

  /// Indicates whether the current device info should be in landscape.
  ///
  /// This is true only if the device can rotate.
  bool isLandscape(Orientation orientation) {
    return canRotate && orientation == Orientation.landscape;
  }
}
