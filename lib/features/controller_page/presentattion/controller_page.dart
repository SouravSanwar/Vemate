import 'dart:io';

import 'package:bottom_bar_page_transition/bottom_bar_page_transition.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
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

late String routeToGo = '/';

class ControllerPage extends StatefulWidget {
  const ControllerPage({Key? key}) : super(key: key);

  @override
  State<ControllerPage> createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  late int productId;
  PostData? postData;

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
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Duration duration = const Duration(milliseconds: 300);

  Curve curve = Curves.ease;

  TransitionType transitionType = TransitionType.fade;

  AppUpdate? appUpdate;
  GetData? getData;

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    // TODO: implement initState
    postData = Provider.of<PostData>(context, listen: false);

    appUpdate = Provider.of<AppUpdate>(context, listen: false);
    /*getData = Provider.of<GetData>(context, listen: false);
    getData!.getUserInfo();*/
    appUpdate!.getUpdateInfo();
    super.initState();
    getToken();
    initMessaging();
    initPlatformState();

    //mode = prefs!.getInt('mode');
    print('Color Mode Cont: ' + mode.toString());
  }

  Future<void> _firebaseMsg(RemoteMessage message) async {
    print("Handling a background message : ${message}");

    productId = int.tryParse(message.data["id"]) ?? 0;
    if (message.notification!.body != null) {
      message.data["type"] == 0
          ? navigatorKey.currentState?.pushNamed('/collectibles_details')
          : navigatorKey.currentState?.pushNamed('/comic_details');
    }
    /*message.data["type"] == 0
        ? Navigator.push(
            navigatorKey.currentState!.context,
            MaterialPageRoute(
              builder: (context) => CollectibleDetails(
                productId: productId,
              ),
            ),
          )
        : Navigator.push(
            navigatorKey.currentState!.context,
            MaterialPageRoute(
              builder: (context) => ComicDetails(
                productId: productId,
              ),
            ),
          );*/
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
            gradient: AppColors.cardGradient,
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
                          'assets/media/icon/logo v.png',
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
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                AppSpaces.spaces_height_10,
                Text(
                  'Are you sure to exit?',
                  style: TextStyle(color: AppColors.textColor),
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
                            style: TextStyle(color: AppColors.textColor),
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
                            style: TextStyle(color: AppColors.textColor),
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
    return true; // return true if the route to be popped
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ControllerPageController());
    return Obx(() {
      printInfo(info: prefs!.getString('token').toString());

      return WillPopScope(
        onWillPop: _willPopCallback,
        child: Stack(
          children: [
            Scaffold(
                backgroundColor: AppColors.backgroundColor,
                body: BottomBarPageTransition(
                  builder: (_, index) => getBody(index),
                  currentIndex: ControllerPageController.to.currentPage.value,
                  totalLength:
                      ControllerPageController.to.bottomBarData!.length,
                  transitionType: transitionType,
                  transitionDuration: duration,
                  transitionCurve: curve,
                ),
                bottomNavigationBar: SizedBox(
                  //height: 65,
                  child: getBottomBar(),
                )),
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
    });
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
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(50.0),
        topRight: Radius.circular(50.0),
      ),
      child: BottomNavigationBar(
        backgroundColor: AppColors.backgroundColor,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        currentIndex: ControllerPageController.to.currentPage.value,
        onTap: (index) {
          ControllerPageController.to.currentPage.value = index;
        },
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedItemColor: AppColors.iconColor,
        unselectedItemColor: AppColors.textColor,
        showUnselectedLabels: true,
        items: List.generate(
          ControllerPageController.to.bottomBarData!.length,
          (index) => BottomNavigationBarItem(
            icon: Icon(icons[index]),
            label: names[index],
          ),
        ),
      ),
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
    var androidInit =
        const AndroidInitializationSettings('assets/media/icon/logo v.png');
    var iosInit = const IOSInitializationSettings();
    var initSetting =
        InitializationSettings(android: androidInit, iOS: iosInit);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initSetting);
    var androidDetails = const AndroidNotificationDetails('1', 'Default',
        channelDescription: "Channel Description",
        importance: Importance.high,
        priority: Priority.high);
    var iosDetails = const IOSNotificationDetails();

    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    ///On Message
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      printInfo(info: "On Message: " + message.data.toString());
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;

      productId = int.tryParse(message.data["id"]) ?? 0;

      if (message.notification!.body != null) {
        message.data["type"] == 0
            ? navigatorKey.currentState?.pushNamed('/collectibles_details')
            : navigatorKey.currentState?.pushNamed('/comic_details');
      }

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(notification.hashCode,
            notification.title, notification.body, generalNotificationDetails);
      }
    });

    ///On Message Open
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("onMessageOpenedApp: ${message.data}");
      productId = int.tryParse(message.data["id"]) ?? 0;
      print("onMessageOpenedApp Product Id: " + productId.toString());

      message.data["type"] == 0
          ? navigatorKey.currentState?.pushNamed('/collectibles_details')
          : navigatorKey.currentState?.pushNamed('/comic_details');

      /*if (message.notification!.body != null) {
        print("onMessageOpenedApp Product Id: " + productId.toString());
        message.data["type"] == 0
            ? navigatorKey.currentState?.pushNamed('/collectibles_details')
            : navigatorKey.currentState?.pushNamed('/comic_details');
      }*/

      /*if (message.data["navigation"] == "/your_route") {
        int _yourId = int.tryParse(message.data["id"]) ?? 0;
        Navigator.push(
          navigatorKey.currentState!.context,
          MaterialPageRoute(
            builder: (context) => CollectibleDetails(
              productId: _yourId,
            ),
          ),
        );
      }*/
    });
  }
}
