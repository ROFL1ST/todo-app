import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/services.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:todo_app/app/controller/global_controller.dart';
import 'package:todo_app/app/data/services/socket.dart';
import 'app/routes/app_pages.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize('resource://drawable/icon_notif', [
    NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Inbox Notification',
        channelDescription: 'Notification For Todo',
        importance: NotificationImportance.High,
        defaultColor: Colors.red,
        criticalAlerts: true,
        enableLights: true,
        enableVibration: true,
        channelShowBadge: true)
  ]);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final storage = GetStorage();
  bool areNotificationsAllowed =
      await AwesomeNotifications().isNotificationAllowed();

  // If notifications are not allowed, request permission
  if (!areNotificationsAllowed) {
    await AwesomeNotifications().requestPermissionToSendNotifications();
  }
  FirebaseMessaging.instance.subscribeToTopic("notif");
  await FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    var user = Jwt.parseJwt(storage.read("token"))["id"].toString();
    // Extract notification data and show notification using awesome_notifications
    log("${message.data["id_user"]} 000");
    if (user != null && user == message.data["id_user"].toString()) {
      showAwesomeNotification(
        title: message.data["title"],
        body: message.data["body"],
      );
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final storage = GetStorage();

  @override
  void initState() {
    // TODO: implement initState
    // if (storage.read("token") != null) {
    //   final WebSocketController webSocketController =
    //       Get.put(WebSocketController());
    //   webSocketController.connectWebSocket();
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        colorScheme: ThemeData.dark().colorScheme,
      ),
    );
  }
}

showAwesomeNotification({required String title, required String body}) async {
  // Define notification content
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'basic_channel',
      title: title,
      body: body,
      notificationLayout: NotificationLayout.Inbox,
    ),
  );
}

createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(1);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final storage = GetStorage();

  var user = Jwt.parseJwt(storage.read("token"))["id"].toString();
  // Extract notification data and show notification using awesome_notifications
  log("${message.data["id_user"]} 000");
  if (user != null && user == message.data["id_user"].toString()) {
    showAwesomeNotification(
      title: message.data["title"],
      body: message.data["body"],
    );
  }
}
