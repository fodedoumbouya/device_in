
![Logo](https://github.com/fodedoumbouya/device_in/assets/47141813/7a3641f0-d277-4c56-a8c6-671246f82a3e)




This package helps you to showcase your project or play with Mobile OS interface for any kind of projects.

All the functions are ready include in the package such as: 

* Window management system
* Customizable toast notifications
* OS-specific functionalities



![App Screenshot](https://github.com/fodedoumbouya/device_in/assets/47141813/9ee88795-acaa-464b-bf1c-e314520d17ae)


## Demo

![demo](https://github.com/fodedoumbouya/device_in/assets/47141813/77b0fe56-6719-4675-b44a-77b469c6014a)

https://github.com/fodedoumbouya/device_in/assets/47141813/34d41b57-da68-4ab4-9d88-007ef95aea0b





See real examples:

* <https://github.com/fodedoumbouya/device_in/tree/main/example>

## Table of contents

Run this command:

With Flutter:

```dart
flutter pub add device_in
```

This will add a line like this to your package's pubspec.yaml with the latest version (and run an implicit flutter pub get):

```js
dependencies:
  device_in: <latest_version>
```

Alternatively, your editor might support flutter pub get. Check the docs for your editor to learn
more about it.

Import the package in your code:

```dart 
import 'package:device_in/device_in.dart';
```

You can use standard device_in like so :

```dart
    DeviceIn(
        device: Devices.ios.iPhone13ProMax,
        deviceNavigationController: DeviceNavigationController(apps: [],
        bottomApps: [],
            ),
        ),

```


## Properties of ```DeviceApplication```

| Property | Type | Default Value | Description |
|----------|------|---------------|-------------|
| appName | String | Required | The name of the application |
| appNameStyle | TextStyle? | null | The style of the application name |
| iconImage | String? | null | The path to the icon of the application (supports asset path or URL) |
| iconImageWidget | Widget? | null | A custom widget for the application icon |
| appEntry | EntryWidgetBuilder? | null | The entry point widget of the application |
| onTap | Function()? | null | Callback function when the application is tapped |
| isBigWidget | bool | false | Whether the widget is displayed as a large widget |

Important notes:
- Either `iconImage` or `iconImageWidget` must be provided, but not both.
- Either `appEntry` or `onTap` must be provided, but not both.
- `appName` is required.

Additional information:
- `EntryWidgetBuilder` is defined as:
  ```dart
  typedef EntryWidgetBuilder = Widget Function(DeviceNavigationController controller);
  ```

## License

[MIT](https://choosealicense.com/licenses/mit/)

