import 'package:device_in/device_in.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  DeviceNavigationController navigationController = DeviceNavigationController(

      /// [deviceBackgroundImage] is a string that holds the path to the background image of the device.
      /// supported network images and assets images.
      // deviceBackgroundImage: "assets/iphone_wal.png",

      /// [apps] is a list of [DeviceApplication] that holds the applications that are displayed on the device.
      apps: [
        DeviceApplication(
          /// [appName] is a string that holds the name of the application.
          appName: 'Flutter',

          /// [isBigWidget] is a boolean that holds the state of the widget.
          isBigWidget: true,

          /// [appEntry] is a widget that holds the entry point of the application or the first widget to open on launch.
          /// if you just want to know when the app is tapped, you can use [onTap] instead.
          appEntry: (controller) {
            return FlutterScreen(controller: controller);
          },

          /// [iconImage] is a string that holds the path to the icon of the application.
          iconImage: 'assets/flutter.png',
        ),
        DeviceApplication(
          appName: 'calendar',
          isBigWidget: false,
          appEntry: (controller) {
            return const Center(child: Text('calendar'));
          },
          iconImage: 'assets/calendar.png',
        ),
        DeviceApplication(
          appName: 'iMessage',
          isBigWidget: false,
          appEntry: (controller) {
            return const Center(child: Text('iMessage'));
          },
          iconImage: 'assets/iMessage.png',
        ),
      ],

      /// [bottomApps] is a list of applications that will be displayed in the bottom bar of the device.
      bottomApps: [
        DeviceApplication(
          appName: 'Safari',
          isBigWidget: false,
          appEntry: (controller) {
            return const Center(child: Text('Safari'));
          },
          iconImage: 'assets/safari.png',
        ),
      ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DeviceIn(
              device: Devices.ios.iPhone13ProMax,
              deviceOccupySize: 900,
              deviceNavigationController: navigationController,
            ),
          ],
        ),
      ),
    );
  }
}

class FlutterScreen extends StatelessWidget {
  final DeviceNavigationController controller;
  const FlutterScreen({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('FlutterScreen'),
          backgroundColor: Colors.blue,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                controller.goBack();
              }),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('FlutterScreen'),
              ElevatedButton(
                  onPressed: () {
                    controller.showToast(
                      content: const Text('this is a toast message'),
                      title: const Text('Toast title'),
                      leading: const Icon(Icons.info),
                    );
                  },
                  child: const Text('display toast')),
            ],
          ),
        ));
  }
}
