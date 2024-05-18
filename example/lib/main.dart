import 'package:device_in/device_in.dart';
import 'package:example/appWidgetBox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;
  List<Widget> pages = [];

  Widget? testWidget;

  /// explaination:
  /// we will have a list of apps and we have to separate them into pages
  /// logic:
  /// [pages] is a map that will hold the pages and the score of the page
  /// [score] is the score of the page and will be use to know if the page is full or not
  /// [apps] is the list of apps that will be separated into pages
  /// during the loop we will check if the app is a big widget or not
  /// if it is a big widget we will add 4 to the score
  /// if it is not we will add 1 to the score
  /// if the app score plus the page score is greater than or equal to 24 we will add the app to the current page index
  /// if not we will create a new page and add the app to it
  void separateAppsToPages() {
    final List<IOSApplications> apps = [
      ...getApplications(),
      ...getApplications(),
      ...getApplications(),
      ...getApplications(),
      ...getApplications(),
      ...getApplications(),
      ...getApplications(),
    ];
    int score = 0;
    List<IOSApplications> currentPage = [];
    for (final app in apps) {
      score += switch (app.isBigWidget) {
        true => 4,
        false => 1,
      };
      if (score > 24) {
        score = score - 24;
        pages.add(_pageGridViewArrangement(apps: currentPage));
        currentPage = [];
      }
      currentPage.add(app);
    }
    if (currentPage.isNotEmpty) {
      pages.add(_pageGridViewArrangement(apps: currentPage));
    }

    _pageViewController = PageController();
    _tabController = TabController(length: pages.length, vsync: this);
    if (mounted) {
      setState(() {});
    }
  }

  Widget _pageGridViewArrangement({required List<IOSApplications> apps}) {
    return StaggeredGrid.count(
      crossAxisCount: 4,
      mainAxisSpacing: 5,
      crossAxisSpacing: 0,
      axisDirection: AxisDirection.down,
      children: [
        ...apps.map((app) {
          final cellCount = app.isBigWidget ? 2 : 1;
          return StaggeredGridTile.count(
              crossAxisCellCount: cellCount,
              mainAxisCellCount: cellCount,
              child: LayoutBuilder(builder: (context, constraints) {
                final size = constraints.biggest;
                return AppWidgetBox(
                  appName: app.appName,
                  iconPath: app.iconImage,
                  onTapDown: (onTapDown) {
                    openApplicationInPhone(size);
                  },
                );
              }));
        }),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    separateAppsToPages();
  }

  void _handlePageViewChanged(int currentPageIndex) {
    _tabController.index = currentPageIndex;
  }

  AnimationController? controller;

  /// This function open the widget in the semulator with an animation
  openApplicationInPhone(Size size) {
    controller = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    Animation<double> curve = CurvedAnimation(
        parent: controller!, curve: Curves.fastEaseInToSlowEaseOut); //easeOut
    const page = Scaffold(
      body: Center(
        child: Text("Hello World"),
      ),
    );

    curve.addListener(() {
      // isUp = true;
      bool isVisible = curve.value >= 0.95;
      //curve.status == AnimationStatus.completed;
      // print(curve.value);
      testWidget = _buildTransition(
        isVisible
            ? Container(
                key: const Key("current"),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: page,
              )
            : Container(
                key: const Key("replacement"),
                alignment: Alignment.center,
                color: Colors.white,
              ),
        curve,
        size,
      );
      // openWidgetPhone(
      //   context: context,
      //   key: fabKey,
      //   animation: curve,
      //   fabOffset: animationOffset,
      //   child: isVisible
      //       ? c(
      //           key: const Key("current"),
      //           h: s.height,
      //           w: s.width,
      //           alig: Alignment.center,
      //           child: applicationView[currentApplicationOpen]!.last,
      //         )
      //       : c(
      //           key: const Key("replacement"),
      //           alig: Alignment.center,
      //           color: Colors.white,
      //         ),
      // );
      setState(() {});
    });
    controller!.forward();
  }

  Widget _buildTransition(
    Widget page,
    Animation<double> animation,
    Size fabSize,
  ) {
    if (animation.value == 1) return page;

    final borderTween = BorderRadiusTween(
      begin: BorderRadius.circular(fabSize.width / 2),
      end: BorderRadius.circular(30),
    );
    final sizeTween = SizeTween(
      begin: fabSize,
      end: MediaQuery.of(context).size,
    );
    final offsetTween = Tween<Offset>(
      begin: localPositionl,
      end: Offset.zero,
    );

    final easeInAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeIn,
    );

    final radius = borderTween.evaluate(easeInAnimation);
    final offset = offsetTween.evaluate(animation);
    final size = sizeTween.evaluate(easeInAnimation);
    Widget positionedClippedChild(Widget child) => Positioned(
        width: size!.width,
        height: size.height,
        left: offset.dx,
        top: offset.dy,
        child: ClipRRect(
          borderRadius: radius ?? BorderRadius.zero,
          child: child,
        ));

    return
        //  positionedClippedChild(page);
        Stack(
      children: [
        positionedClippedChild(page),

        // positionedClippedChild(transitionFab),
      ],
    );
    // }
  }

  Offset localPositionl = const Offset(0, 0);

  Widget bottomHomeBack() => Positioned(
        bottom: 10,
        left: 20,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onVerticalDragUpdate: (details) {
              // check that if the user swiped up then close the app
              if (details.primaryDelta! < -1) {
                // User swiped up

                controller!.addListener(() {
                  if (controller!.status == AnimationStatus.dismissed) {
                    testWidget = null;
                    controller!.dispose();
                    controller = null;
                    setState(() {});
                  }
                });
                controller!.reverse();
              }
            },
            child: Container(
                height: 10,
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                )),
          ),
        ),
      );

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
                screen: LayoutBuilder(
                  builder: (contextMobile, constraints) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: const AssetImage('assets/iphone_wal.png'),
                          scale: MediaQuery.of(context).devicePixelRatio,
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Listener(
                        onPointerDown: (event) {
                          /// we will use this to get the local position of the tap
                          /// to use it in the animation
                          localPositionl = event.localPosition;
                        },
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 70),
                              child: PageView(
                                /// [PageView.scrollDirection] defaults to [Axis.horizontal].
                                /// Use [Axis.vertical] to scroll vertically.
                                controller: _pageViewController,
                                onPageChanged: _handlePageViewChanged,
                                children: <Widget>[
                                  ...pages,
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter
                                  .add(const Alignment(0, -0.35)),
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: TabPageSelector(
                                  controller: _tabController,
                                  color: Colors.grey,
                                  selectedColor: Colors.white,
                                  borderStyle: BorderStyle.none,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 100,
                                margin: const EdgeInsets.only(
                                    bottom: 20, left: 10, right: 10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                            if (testWidget != null) testWidget!,
                            if (testWidget != null) bottomHomeBack(),
                          ],
                        ),
                      ),
                    );
                  },
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
        appEntry: const Text('App 111'),
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

class IOSApplications {
  Key? key;
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
    this.key,
  });
}
