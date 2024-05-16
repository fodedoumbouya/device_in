import 'package:device_in/device_in.dart';
import 'package:example/appWidgetBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DeviceIn(
                device: Devices.ios.iPhone13ProMax,
                orientation: Orientation.portrait,
                deviceOccupySize: 900,
                screen: Container(
                  // color: Colors.red,
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage('assets/iphone_wal.png'),
                      scale: MediaQuery.of(context).devicePixelRatio,
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: StaggeredGrid.count(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 20,
                    children: [
                      ...getApplications().map((app) {
                        final cellCount = app.isBigWidget ? 2 : 1;
                        return StaggeredGridTile.count(
                            crossAxisCellCount: cellCount,
                            mainAxisCellCount: cellCount,
                            child: AppWidgetBox(
                              appName: app.appName,
                              iconPath: app.iconImage,
                            ));
                      }),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  List<IOSApplications> getApplications() {
    return [
      IOSApplications(
        appName: 'App 1',
        isBigWidget: true,
        appEntry: const Text('App 1'),
        iconImage: 'assets/appIcons/jufe.png',
      ),
      IOSApplications(
        appName: 'App 2',
        appEntry: Container(
          color: Colors.blue,
          padding: const EdgeInsets.all(3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  // image: iconPath == null ? null : "appIcons/$iconPath",
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ]),
                  child: const FlutterLogo(),
                  // iconPath == null ? widget : null,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              const Text("App 2"),
            ],
          ),
        ),
        iconImage: 'assets/appIcons/projectX.png',
      ),
      IOSApplications(
        appName: 'App 3',
        appEntry: Container(
          color: Colors.green,
        ),
        iconImage: 'assets/appIcons/remora.png',
      ),
      IOSApplications(
        appName: 'App 4',
        appEntry: Container(
          color: Colors.yellow,
        ),
        iconImage: 'assets/appIcons/jufe.png',
      ),
      IOSApplications(
        appName: 'App 5',
        appEntry: Container(
          color: Colors.purple,
        ),
        iconImage: 'assets/appIcons/projectX.png',
      ),
      IOSApplications(
        appName: 'App 6',
        isBigWidget: true,
        appEntry: Container(
          color: Colors.orange,
        ),
        iconImage: 'assets/appIcons/remora.png',
      ),
      IOSApplications(
        appName: 'App 7',
        appEntry: Container(
          color: Colors.pink,
        ),
        iconImage: 'assets/appIcons/jufe.png',
      ),
      IOSApplications(
        appName: 'App 8',
        appEntry: Container(
          color: Colors.teal,
        ),
        iconImage: 'assets/appIcons/projectX.png',
      ),
      IOSApplications(
        appName: 'App 9',
        appEntry: Container(
          color: Colors.brown,
        ),
        iconImage: 'assets/appIcons/remora.png',
      ),
      IOSApplications(
        appName: 'App 10',
        appEntry: Container(
          color: Colors.grey,
        ),
        iconImage: 'assets/appIcons/jufe.png',
      ),
    ];
  }
}

class MyHomePage2 extends StatelessWidget {
  const MyHomePage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Multi-Widget Layout'),
        ),
        body: StaggeredGrid.count(
          crossAxisCount: 4,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          children: [
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 2,
              child: Container(
                color: Colors.blue,
                child: const Center(
                  child: Text('Big Tile'),
                ),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 1,
              child: Container(
                color: Colors.green,
                child: const Center(
                  child: Text('Tile 1'),
                ),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: Container(
                color: Colors.red,
                child: const Center(
                  child: Text('Tile 2'),
                ),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: Container(
                color: Colors.yellow,
                child: const Center(
                  child: Text('Tile 3'),
                ),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 4,
              mainAxisCellCount: 2,
              child: Container(
                color: Colors.purple,
                child: const Center(
                  child: Text('Big Tile'),
                ),
              ),
            ),
          ],
        ));
  }
}

// Custom Widget for Time & Weather
class TimeWeatherWidget extends StatelessWidget {
  const TimeWeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '19:54',
          style: TextStyle(fontSize: 24.0),
        ),
        Row(
          children: [
            Text(
              'Corte, 15°',
              style: TextStyle(fontSize: 16.0),
            ),
            Icon(Icons.sunny),
          ],
        ),
      ],
    );
  }
}

// Custom Widget for Center Tile
class CenterTileWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color iconColor;

  const CenterTileWidget({
    super.key,
    required this.text,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 32.0),
          ),
          const SizedBox(width: 10.0),
          Icon(
            icon,
            size: 32.0,
            color: iconColor,
          ),
        ],
      ),
    );
  }
}

// Custom Widget for Info Tiles
class InfoTileWidget extends StatelessWidget {
  final IconData icon1;
  final String text1;
  final IconData icon2;
  final String text2;
  final IconData icon3;
  final String text3;

  const InfoTileWidget({
    super.key,
    required this.icon1,
    required this.text1,
    required this.icon2,
    required this.text2,
    required this.icon3,
    required this.text3,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon1),
            const SizedBox(width: 5.0),
            Text(text1),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon2),
            const SizedBox(width: 5.0),
            Text(text2),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon3),
            const SizedBox(width: 5.0),
            Text(text3),
          ],
        ),
      ],
    );
  }
}

class IOSApplications {
  final String appName;
  final String? iconImage;
  final Widget? iconImageWidget;
  final Widget appEntry;
  final bool isBigWidget;
  IOSApplications({
    required this.appName,
    required this.appEntry,
    this.iconImage,
    this.iconImageWidget,
    this.isBigWidget = false,
  });
}
