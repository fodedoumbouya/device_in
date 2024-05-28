// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../controller/deviceNavigationController.dart';
import '../model/enum.dart';
import '../model/deviceApplication.dart';
import 'widgets/appWidgetBox.dart';

class IosSystemView extends StatefulWidget {
  final DeviceNavigationController navigationController;
  const IosSystemView({required this.navigationController, super.key});

  @override
  State<IosSystemView> createState() => _IosSystemViewState();
}

class _IosSystemViewState extends State<IosSystemView>
    with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;
  AnimationController? controller;
  List<Widget> pages = [];
  final appOpen = ValueNotifier<Widget>(const SizedBox.shrink());
  Offset localPositionl = Offset.zero;
  final isAppOpen = ValueNotifier(false);

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
    int score = 0;
    List<DeviceApplication> currentPage = [];
    for (final app in widget.navigationController.apps) {
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

  /// explaination:
  /// this function will take a list of apps and return a grid view of the apps
  /// the grid view will be a staggered grid view with 4 columns
  /// the cell count will be 2 if the app is a big widget and 1 if not
  /// the app widget will be a [AppWidgetBox] that will take the app name and the icon path
  /// the [onTapDown] will be used to open the application in the phone
  Widget _pageGridViewArrangement({required List<DeviceApplication> apps}) {
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
              child: LayoutBuilder(builder: (context1, constraints) {
                final appSize = constraints.biggest;
                Offset appWidgeCenterOffset =
                    Offset(constraints.maxWidth / 2, constraints.maxHeight / 2);
                // print(appSize);
                return AppWidgetBox(
                  appName: app.appName,
                  iconPath: app.iconImage,
                  appNameStyle: app.appNameStyle,
                  iconCustomWidget: app.iconImageWidget,
                  onTapDown: (onTapDown) {
                    if (app.onTap != null) {
                      app.onTap!();
                      return;
                    }
                    openApplicationInPhone(
                      appSize: appSize,
                      appWidgeCenterOffset: appWidgeCenterOffset,
                      appEntry: app.appEntry!,
                      offset: localPositionl,
                    );
                  },
                );
              }));
        }),
      ],
    );
  }

  @override
  void initState() {
    loadBackground();
    separateAppsToPages();

    /// we will listen to the navigation controller to know the state of the navigation
    widget.navigationController.stateChangeStream.listen((event) {
      if (event == DeviceNavigationControllerState.goBackToRoot) {
        controller?.addListener(() {
          if (controller?.status == AnimationStatus.dismissed) {
            widget.navigationController.goBackToRoot();
            appOpen.value = const SizedBox.shrink();
            controller?.dispose();
            controller = null;
            // setState(() {});
          }
        });
        controller?.reverse(from: 0.5);
      }
      if (event == DeviceNavigationControllerState.goTo ||
          event == DeviceNavigationControllerState.goBack) {
        appOpen.value = widget.navigationController.getCurrentApp();
      }
    });
    super.initState();
  }

  ImageProvider<Object>? bgImage;

  void loadBackground() {
    final src = widget.navigationController.deviceBackgroundImage;
    if (src.contains("http")) {
      bgImage = Image.network(src).image;
    } else {
      bgImage = AssetImage(src);
    }
    if (mounted) {
      setState(() {});
    }
  }

  /// explaination:
  /// this function will open the application in the phone
  /// the function will take the app size, the app widget center offset, the app entry, and the offset of the tap
  /// the function will create an animation controller and a curved animation
  /// the function will listen to the animation and will check if the animation is almost done
  /// if the animation is almost done we will show the app in the phone
  openApplicationInPhone(
      {required Size appSize,
      required Offset appWidgeCenterOffset,
      required Widget appEntry,
      required Offset offset}) {
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    Animation<double> curve = CurvedAnimation(
        parent: controller!, curve: Curves.fastEaseInToSlowEaseOut); //easeOut

    /// we will use the navigation controller to keep track of the apps that are open
    widget.navigationController.goTo(widget: appEntry);

    curve.addListener(() {
      bool isVisible = curve.value >= 0.95;
      isAppOpen.value = isVisible;
      appOpen.value = _buildTransition(
        page: isVisible
            ? Container(
                key: const Key("current"),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                color: Colors.white,
                child: widget.navigationController.getCurrentApp(),
              )
            : Container(
                key: const Key("replacement"),
                alignment: Alignment.center,
                color: Colors.white,
              ),
        animation: curve,
        appIconSize: appSize,
        appWidgeCenterOffset: appWidgeCenterOffset,
        offset: offset,
      );

      // ignore: invalid_use_of_visible_for_testing_member
      appOpen.notifyListeners();
    });
    controller!.forward();
  }

  /// explaination:
  /// this function will build the transition of the app from the grid to the phone
  /// the transition will be a clip rect that will clip the app widget

  Widget _buildTransition(
      {required Widget page,
      required Animation<double> animation,
      required Size appIconSize,
      required Offset appWidgeCenterOffset,
      required Offset offset}) {
    final borderTween = BorderRadiusTween(
      begin: BorderRadius.circular(appIconSize.width / 2),
      end: BorderRadius.circular(30),
    );
    final sizeTween = SizeTween(
      begin: appIconSize,
      end: MediaQuery.of(context).size,
    );
    final offsetTween = Tween<Offset>(
      begin: offset - appWidgeCenterOffset,
      end: Offset.zero,
    );

    final easeInAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeIn,
    );

    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
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

        return Stack(
          children: [
            positionedClippedChild(page),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgImage == null ? Colors.white : null,
        image: bgImage == null
            ? null
            : DecorationImage(
                image: bgImage!,
                scale: MediaQuery.of(context).devicePixelRatio,
                fit: BoxFit.cover,
              ),
      ),
      child: Listener(
        behavior: HitTestBehavior.deferToChild,
        onPointerDown: (event) {
          /// we will use this to get the local position of the tap
          /// to use it in the animation
          localPositionl = event.localPosition;
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.trackpad,
                }),
                child: PageView(
                  controller: _pageViewController,
                  onPageChanged: (index) {
                    _tabController.animateTo(index);
                  },
                  children: <Widget>[
                    ...pages,
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter.add(const Alignment(0, -0.35)),
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
                margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ...widget.navigationController.bottomApps
                        .take(4)
                        .map((app) {
                      return SizedBox(
                        width: 80,
                        height: 100,
                        child: LayoutBuilder(builder: (context, constraints) {
                          final appSize = constraints.biggest;
                          Offset appWidgeCenterOffset = Offset(
                              constraints.maxWidth / 2,
                              constraints.maxHeight / 2);
                          return AppWidgetBox(
                            // appName: app.appName,
                            iconPath: app.iconImage,
                            appNameStyle: app.appNameStyle,
                            iconCustomWidget: app.iconImageWidget,
                            onTapDown: (onTapDown) {
                              /// if the app has a onTap function we will call it
                              if (app.onTap != null) {
                                app.onTap!();
                                return;
                              }
                              openApplicationInPhone(
                                appSize: appSize,
                                appWidgeCenterOffset: appWidgeCenterOffset,
                                appEntry: app.appEntry!,
                                offset: localPositionl,
                              );
                            },
                          );
                        }),
                      );
                    }),
                  ],
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: appOpen,
              builder: (context, value, child) {
                /// if need animation
                return value;
              },
            ),
            ValueListenableBuilder(
              valueListenable: isAppOpen,
              builder: (context, value, child) {
                return switch (value) {
                  true => bottomHomeBack(),
                  false => const SizedBox.shrink(),
                };
              },
            )
          ],
        ),
      ),
    );
  }

  /// explaination:
  /// this function will return a widget that will be used to close the app
  Widget bottomHomeBack() => Align(
        alignment: Alignment.bottomCenter.add(const Alignment(0, -0.02)),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onVerticalDragUpdate: (details) {
              // check that if the user swiped up then close the app
              if (details.primaryDelta! < -1) {
                // User swiped up
                widget.navigationController.goBackToRoot();
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
}
