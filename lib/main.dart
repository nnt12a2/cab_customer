import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cabme/constant/constant.dart';
import 'package:cabme/controller/settings_controller.dart';
import 'package:cabme/page/localization_screens/localization_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'page/auth_screens/login_screen.dart';
import 'page/dash_board.dart';
import 'page/on_boarding_screen.dart';
import 'service/localization_service.dart';
import 'themes/constant_colors.dart';
import 'utils/Preferences.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
void main() async {
  Stripe.publishableKey = Constant.stripePublishablekey;
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();
  await Preferences.initPref();

  await Firebase.initializeApp();
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (!Platform.isIOS) {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<void> setupInteractedMessage(BuildContext context) async {
    initialize(context);
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      log('Message also contained a notification: ${initialMessage.notification!.body}');
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!');
      log('Message data: ${message.data}');

      if (message.notification != null) {
        display(message);
      }
    });
  }

  Future<void> initialize(BuildContext context) async {
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.high,
    );

    await FlutterLocalNotificationsPlugin().resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  }

  void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
        "01",
        "cabme",
        importance: Importance.max,
        priority: Priority.high,
      ));

      await FlutterLocalNotificationsPlugin().show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: jsonEncode(message.data),
      );
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    setupInteractedMessage(context);
    Future.delayed(const Duration(seconds: 3), () {
      if (Preferences.getString(Preferences.languageCodeKey).toString().isNotEmpty) {
        LocalizationService().changeLocale(Preferences.getString(Preferences.languageCodeKey).toString());
      }
      FlutterNativeSplash.remove();
    });
    return GetMaterialApp(
      title: 'CabMe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: ConstantColors.primary,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        primaryTextTheme: GoogleFonts.poppinsTextTheme(),
      ),
      locale: LocalizationService.locale,
      fallbackLocale: LocalizationService.locale,
      translations: LocalizationService(),
      builder: EasyLoading.init(),
      home: GetBuilder(
          init: SettingsController(),
          builder: (controller) {
            return Preferences.getString(Preferences.languageCodeKey).toString().isEmpty
                ? const LocalizationScreens(intentType: "main")
                : Preferences.getBoolean(Preferences.isFinishOnBoardingKey)
                    ? Preferences.getBoolean(Preferences.isLogin)
                        ? DashBoard()
                        : LoginScreen()
                    : const OnBoardingScreen();
          }),
    );
  }
}
