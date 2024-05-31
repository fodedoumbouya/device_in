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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late DeviceNavigationController navigationController;

  @override
  void initState() {
    super.initState();
    navigationController = DeviceNavigationController(
        deviceBackgroundImage: "assets/iphone_wal.png",
        apps: [
          ...getApplications(),
          ...getApplications(),
        ],
        bottomApps: getApplications());
  }

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
              deviceOccupySize: 800,
              deviceNavigationController: navigationController,
            ),
          ],
        ),
      ),
    );
  }

  List<DeviceApplication> getApplications() {
    return [
      DeviceApplication(
        appName: 'App 1',
        isBigWidget: true,
        appEntry: (controller) {
          return const Text('App 111');
        },
        iconImage: 'assets/appIcons/jufe.png',
      ),
      DeviceApplication(
        appName: 'App 1',
        isBigWidget: true,
        appEntry: (controller) {
          return const Text('App 111');
        },
        iconImage: 'assets/appIcons/jufe.png',
      ),
      DeviceApplication(
        appName: 'App 2',
        appEntry: (con) {
          return Container(
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
                    child: GestureDetector(
                        onTap: () {
                          con.goTo(
                              widget: Scaffold(
                            appBar: AppBar(
                              title: const Text('App 2'),
                            ),
                            body: GestureDetector(
                              onTap: () {
                                con.showToast(
                                  content: const Text('App 2'),
                                  title: const Text('App 1'),
                                  leading: const Icon(Icons.info),
                                );
                                // navigationController.goBack();
                              },
                              child: const Center(
                                child: Text('App 2'),
                              ),
                            ),
                          ));
                        },
                        child: const FlutterLogo()),
                    // iconPath == null ? widget : null,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text("App 2"),
              ],
            ),
          );
        },
        iconImage: 'assets/appIcons/projectX.png',
      ),
      DeviceApplication(
        appName: 'App 3',
        appEntry: (controller) {
          return Container(
            color: Colors.green,
          );
        },
        iconImage: 'assets/appIcons/remora.png',
      ),
      // DeviceApplication(
      //   appName: 'App 4',
      //   appEntry: Container(
      //     color: Colors.yellow,
      //   ),
      //   iconImage: 'assets/appIcons/jufe.png',
      // ),
      // DeviceApplication(
      //   appName: 'App 5',
      //   appEntry: Container(
      //     color: Colors.purple,
      //   ),
      //   iconImage: 'assets/appIcons/projectX.png',
      // ),
      // DeviceApplication(
      //   appName: 'App 6',
      //   isBigWidget: true,
      //   appEntry: Container(
      //     color: Colors.orange,
      //   ),
      //   iconImage: 'assets/appIcons/remora.png',
      // ),
      // DeviceApplication(
      //   appName: 'App 7',
      //   appEntry: Container(
      //     color: Colors.pink,
      //   ),
      //   iconImage: 'assets/appIcons/jufe.png',
      // ),
      // DeviceApplication(
      //   appName: 'App 8',
      //   appEntry: Container(
      //     color: Colors.teal,
      //   ),
      //   iconImage: 'assets/appIcons/projectX.png',
      // ),
      // DeviceApplication(
      //   appName: 'App 9',
      //   appEntry: Container(
      //     color: Colors.brown,
      //   ),
      //   iconImage: 'assets/appIcons/remora.png',
      // ),
      // DeviceApplication(
      //   appName: 'App 10',
      //   appEntry: Container(
      //     color: Colors.grey,
      //   ),
      //   iconImage: 'assets/appIcons/jufe.png',
      // ),
    ];
  }
}
