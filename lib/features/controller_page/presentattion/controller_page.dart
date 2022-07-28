import 'dart:io';

import 'package:bottom_bar_page_transition/bottom_bar_page_transition.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/Docker/docker.dart';
import 'package:ketemaa/core/Docker/docker_item.dart';
import 'package:ketemaa/core/Provider/app_update.dart';
import 'package:ketemaa/core/Provider/getData.dart';
import 'package:ketemaa/core/Provider/postData.dart';
import 'package:ketemaa/core/functions/version_control.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/features/Designs/update_alert_dialog.dart';
import 'package:ketemaa/features/controller_page/controller/controller_page_controller.dart';
import 'package:ketemaa/features/home/presentation/home.dart';
import 'package:ketemaa/features/market/presentation/collectible_details.dart';
import 'package:ketemaa/features/market/presentation/comic_details.dart';
import 'package:ketemaa/features/vault/vault.dart';

import 'package:ketemaa/main.dart';
import 'package:provider/provider.dart';

import '../../market/presentation/market.dart';

String? token;

class ControllerPage extends StatefulWidget {
  late int? seletedItem;

  ControllerPage({Key? key, this.seletedItem = 0}) : super(key: key);

  @override
  State<ControllerPage> createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  late int productId;
  PostData? postData;

  //int _seletedItem = 0;
  final _pages = [const Home(), const Market(), const Vault()];
  late PageController pageController = PageController();

  List<String> names = [
    'Home',
    'Market',
    'My Vault',
  ];

  List<IconData> icons = [
    Icons.home,
    Icons.shop,
    Icons.card_travel,
  ];

  Duration duration = const Duration(milliseconds: 300);

  Curve curve = Curves.ease;

  TransitionType transitionType = TransitionType.slide;

  AppUpdate? appUpdate;
  GetData? getData;

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();

    print("Handling a background message: ${message.messageId}");
  }

  @override
  void initState() {
    postData = Provider.of<PostData>(context, listen: false);

    appUpdate = Provider.of<AppUpdate>(context, listen: false);
    getData = Provider.of<GetData>(context, listen: false);
    //getData!.getUserInfo();
    appUpdate!.getUpdateInfo();
    super.initState();
    initPlatformState();
    getToken();
    initMessaging();
    pageController = PageController(initialPage: widget.seletedItem!);
  }

  Future<void> _firebaseMsg(RemoteMessage message) async {
    print("Handling a background message : ${message.data}");

    productId = int.parse(message.data["id"].toString());

    message.data["type"] == 0
        ? Get.to(() => CollectibleDetails(
              productId: productId,
            ))
        : Get.to(() => ComicDetails(
              productId: productId,
            ));
  }

  Future<void> initPlatformState() async {
    WidgetsFlutterBinding.ensureInitialized();

    FirebaseMessaging.onBackgroundMessage(_firebaseMsg);
    await Firebase.initializeApp();
  }

  Future<bool> _willPopCallback() async {
    Get.dialog(
      Dialog(
        backgroundColor: AppColors.backgroundColor,
        child: Container(
          width: Get.height * .25,
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    children: [
                      SizedBox(
                        height: Get.height * .02,
                        width: Get.height * .02,
                        child: Image.asset(
                          'assets/media/icon/logo_v.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        width: Get.height * .01,
                      ),
                      Text(
                        "Vemate",
                        style: Get.textTheme.headline1!.copyWith(
                            color: AppColors.textColor,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                AppSpaces.spaces_height_10,
                Text(
                  'Are you sure to exit?',
                  style: TextStyle(
                      fontFamily: 'Inter', color: AppColors.textColor),
                ),
                AppSpaces.spaces_height_10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: AppColors.purpleGradient,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'No',
                            style: TextStyle(
                                fontFamily: 'Inter',
                                color: AppColors.textColor),
                          ),
                        ),
                      ),
                    ),
                    AppSpaces.spaces_width_15,
                    InkWell(
                      onTap: () {
                        exit(0);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: AppColors.purpleGradient,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Yes',
                            style: TextStyle(
                                fontFamily: 'Inter',
                                color: AppColors.textColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ControllerPageController());
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: AppColors.backgroundColor,
            body: PageView(
              children: _pages,
              onPageChanged: (index) {
                setState(() {
                  widget.seletedItem = index;
                });
              },
              controller: pageController,
            ),
            bottomNavigationBar: Docker(
              onTap: (int index) {
                setState(() {
                  widget.seletedItem = index;
                  pageController.animateToPage(widget.seletedItem!,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.linear);
                });
              },
              currentIndex: widget.seletedItem,
              backgroundColor: AppColors.backgroundColor,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
              selectedBackgroundColor: AppColors.purpleGradient,
              items: [
                DockerItem(
                  icon: Icons.home,
                  title: 'Home',
                ),
                DockerItem(
                  icon: Icons.shop,
                  title: 'Market',
                ),
                DockerItem(
                  icon: Icons.card_travel,
                  title: 'Vault',
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            child: Consumer<AppUpdate>(builder: (context, data, child) {
              return data.appUpdator != null
                  ? (int.parse(data.appUpdator!.name!.toString()) >
                              int.parse(
                                  VersionControl.packageInfo.buildNumber) &&
                          data.isUpdate == true
                      ? const AppUpdateAlert()
                      : Container())
                  : Container();
            }),
          ),
        ],
      ),
    );
  }

  getBody(int index) {
    if (index == 0) {
      return const Home();
    } else if (index == 1) {
      return const Market();
    } else {
      return const Vault();
    }
  }

  getBottomBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.transparent,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      selectedItemColor: AppColors.iconColor,
      selectedIconTheme: const IconThemeData(),
      unselectedItemColor: AppColors.textColor,
      showUnselectedLabels: true,
      items: List.generate(
        ControllerPageController.to.bottomBarData!.length,
        (index) {
          return BottomNavigationBarItem(
            icon: Icon(icons[index]),
            label: names[index],
            activeIcon: ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  colors: [
                    Color(0xff8760EE),
                    Color(0xffA984E5),
                    Color(0xffCA88E8),
                  ],
                  tileMode: TileMode.repeated,
                ).createShader(bounds);
              },
              child: Icon(icons[index]),
            ),
          );
        },
      ),
      currentIndex: widget.seletedItem!,
      onTap: (index) {
        setState(() {
          widget.seletedItem = index;
          pageController.animateToPage(widget.seletedItem!,
              duration: const Duration(milliseconds: 200),
              curve: Curves.linear);
        });
      },
    );
  }

  void getToken() {
    _messaging.getToken().then((value) {
      token = value;

      print("Device Token:" + token!);
      var body = {"fcm_device_id": token!};
      Map<String, String> requestHeadersWithToken = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'token ${prefs!.getString('token')}',
      };
      postData!.updateFCMToken(context, body, requestHeadersWithToken);
    });
  }

  void initMessaging() {
    //DidReceiveLocalNotificationCallback? onDidReceiveLocalNotification;

    var androidDetails = const AndroidNotificationDetails(
      '1',
      'Default',
      channelDescription: "Channel Description",
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
    );

    var iosDetails = const IOSNotificationDetails();

    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    void onDidReceiveLocalNotification(
        int id, String? title, String? body, String? payload) async {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              backgroundColor: AppColors.primaryColor,
              title: Text(title.toString()),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(body.toString())],
                ),
              ),
            );
          });
    }

    var androidInit =
        const AndroidInitializationSettings('assets/media/icon/logo_v.png');

    final IOSInitializationSettings iosInit = IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    var initSetting =
        InitializationSettings(android: androidInit, iOS: iosInit);

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initSetting);

    FirebaseMessaging.onBackgroundMessage((message) async {
      productId = int.parse(message.data["id"].toString());
      print("onMessageOpenedApp Product Id: " + productId.toString());

      Map<String, String> requestHeadersWithToken = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'token ${prefs!.getString('token')}',
      };

      if (message.data["type"] == 0) {
        setState(() {
          postData!
              .notificationRead(context, productId, requestHeadersWithToken);
        });
        Get.to(() => CollectibleDetails(
              productId: productId,
            ));
      } else {
        setState(() {
          postData!
              .notificationRead(context, productId, requestHeadersWithToken);
        });
        Get.to(
          () => ComicDetails(
            productId: productId,
          ),
        );
      }
    });

    ///Foreground Notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(notification.hashCode,
            notification.title, notification.body, generalNotificationDetails);
      }
    });

    ///Background Notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("onMessageOpenedApp: ${message.data}");
      productId = int.parse(message.data["id"].toString());

      Map<String, String> requestHeadersWithToken = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'token ${prefs!.getString('token')}',
      };

      if (message.data["type"] == 0) {
        setState(() {
          postData!
              .notificationRead(context, productId, requestHeadersWithToken);
        });
        Get.to(() => CollectibleDetails(
              productId: productId,
            ));
      } else {
        setState(() {
          postData!
              .notificationRead(context, productId, requestHeadersWithToken);
        });
        Get.to(
          () => ComicDetails(
            productId: productId,
          ),
        );
      }
    });

    ///Notification When App Closed
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        productId = int.parse(message.data["id"].toString());

        Map<String, String> requestHeadersWithToken = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'token ${prefs!.getString('token')}',
        };

        if (message.data["type"] == 0) {
          setState(() {
            postData!
                .notificationRead(context, productId, requestHeadersWithToken);
          });
          Get.to(() => CollectibleDetails(
                productId: productId,
              ));
        } else {
          setState(() {
            postData!
                .notificationRead(context, productId, requestHeadersWithToken);
          });
          Get.to(
            () => ComicDetails(
              productId: productId,
            ),
          );
        }

        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        AppleNotification? apple = message.notification?.apple;

        if (notification != null && android != null && apple != null) {
          flutterLocalNotificationsPlugin.show(notification.hashCode,
              notification.title, notification.body, generalNotificationDetails,
              payload: message.data["type_id"].toString());

          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  backgroundColor: AppColors.primaryColor,
                  title: Text(notification.title.toString()),
                  content: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(notification.body.toString()),
                      ],
                    ),
                  ),
                );
              });
        }
      }
    });
  }
}
