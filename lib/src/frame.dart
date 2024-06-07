import 'package:device_in/src/system/controller/deviceNavigationController.dart';
import 'package:device_in/src/system/iosSystemView/iosSystemView.dart';
import 'package:device_in/src/utils/deviceInfo.dart';
import 'package:flutter/material.dart';

/// The [DeviceIn.identifier] constructor loads an SVG file from assets to get device frame visuals and device info.
/// Use the [DeviceIn.info] constructor to preload the device info instead.
///
/// See [Devices] for a list of available devices.
///
class DeviceIn extends StatelessWidget {
  /// The screen that should be inserted into the simulated
  /// device.

  /// [DeviceNavigationController] is a controller that helps to navigate between different applications
  /// and keep track of the current state of the application. It is used to manage the navigation between applications
  final DeviceNavigationController deviceNavigationController;

  /// All information related to the device.
  final DeviceInfo device;

  /// Indicates whether the device frame is visible, else
  /// only the screen is displayed.
  final bool isFrameVisible;

  /// [deviceOccupySize] is the size of the device in the screen
  final double? deviceOccupySize;

  /// example:
  /// ```dart
  /// DeviceIn(
  ///  device: Devices.ios.iPhone13ProMax,
  /// deviceNavigationController: navigationController,
  /// )
  /// ```
  /// [DeviceIn] is a widget that displays a device frame with a screen inside it.
  const DeviceIn({
    super.key,
    required this.device,
    this.deviceOccupySize,
    this.isFrameVisible = true,
    required this.deviceNavigationController,
  });

  /// Creates a [MediaQuery] from the given device [info], and for the current device [orientation].
  ///
  /// All properties that are not simulated are inherited from the current [context]'s inherited [MediaQuery].
  static MediaQueryData mediaQuery({
    required BuildContext context,
    required DeviceInfo? info,
  }) {
    final mediaQuery = MediaQuery.of(context);
    final viewPadding = (info?.safeAreas ?? mediaQuery.padding);

    final screenSize = info != null ? info.screenSize : mediaQuery.size;
    final width = screenSize.width;
    final height = screenSize.height;

    return mediaQuery.copyWith(
      size: Size(width, height),
      padding: viewPadding,
      viewInsets: EdgeInsets.zero,
      viewPadding: viewPadding,
      devicePixelRatio: info?.pixelRatio ?? mediaQuery.devicePixelRatio,
    );
  }

  ThemeData _theme(BuildContext context) {
    return Theme.of(context).copyWith(
      platform: device.identifier.platform,
      // visualDensity: density,
    );
  }

  Widget _screen(BuildContext context, DeviceInfo? info) {
    final mediaQuery = MediaQuery.of(context);
    // final isRotated = info?.isLandscape(orientation) ?? false;
    final screenSize = info != null ? info.screenSize : mediaQuery.size;
    final width = screenSize.width;
    final height = screenSize.height;
    final screen = switch (device.identifier.platform == TargetPlatform.iOS) {
      true => IosSystemView(navigationController: deviceNavigationController),
      false => _notSupport,
    };
    return SizedBox(
      width: width,
      height: height,
      child: MediaQuery(
        data: DeviceIn.mediaQuery(
          info: info,
          context: context,
        ),
        child: Theme(
          data: _theme(context),
          child: screen,
        ),
      ),
    );
  }

  Widget get _notSupport => Container(
        color: Colors.blue,
        child: const Center(
          child: Text(
            'Not supported',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final frameSize = device.frameSize;
    final bounds = device.screenPath.getBounds();
    final mediaQuery = MediaQuery.of(context);
    final screenSize = deviceOccupySize == null
        ? mediaQuery.size
        : Size(deviceOccupySize!, deviceOccupySize!);

    final stack = SizedBox(
      width: isFrameVisible ? frameSize.width : bounds.width,
      height: isFrameVisible ? frameSize.height : bounds.height,
      child: Stack(
        children: [
          if (isFrameVisible)
            Positioned.fill(
              key: const Key('frame'),
              child: CustomPaint(
                key: ValueKey(device.identifier),
                painter: device.framePainter,
              ),
            ),
          Positioned(
            key: const Key('Screen'),
            left: isFrameVisible ? bounds.left : 0,
            top: isFrameVisible ? bounds.top : 0,
            width: bounds.width,
            height: bounds.height,
            child: ClipPath(
              clipper: _ScreenClipper(
                device.screenPath,
              ),
              child: FittedBox(
                child: _screen(context, device),
              ),
            ),
          ),
        ],
      ),
    );

    return SizedBox(
      width: screenSize.width,
      height: screenSize.height,
      child: FittedBox(
        child: stack,
      ),
    );
  }
}

class _ScreenClipper extends CustomClipper<Path> {
  const _ScreenClipper(this.path);

  final Path? path;

  @override
  Path getClip(Size size) {
    final path = (this.path ?? (Path()..addRect(Offset.zero & size)));
    final bounds = path.getBounds();
    var transform = Matrix4.translationValues(-bounds.left, -bounds.top, 0);

    return path.transform(transform.storage);
  }

  @override
  bool shouldReclip(_ScreenClipper oldClipper) {
    return oldClipper.path != path;
  }
}
