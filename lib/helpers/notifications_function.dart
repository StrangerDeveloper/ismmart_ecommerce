import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ismmart_ecommerce/helpers/urls.dart';
import 'api_base_helper.dart';

class NotificationsServices {

  //initialising firebase message plugin
  FirebaseMessaging messaging = FirebaseMessaging.instance ;

  //initialising firebase message plugin
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin  = FlutterLocalNotificationsPlugin();

  //function to initialise flutter local notification plugin to show notifications for android when app is active
  void initLocalNotifications(BuildContext context, RemoteMessage message)async{
    var androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
        android: androidInitializationSettings ,
        iOS: iosInitializationSettings
    );

    await _flutterLocalNotificationsPlugin.initialize(
        initializationSetting,
        onDidReceiveNotificationResponse: (payload){
          // handle interaction when app is active for android
          handleMessage(context, message);
        }
    );
  }

  void firebaseInit(BuildContext context){

    FirebaseMessaging.onMessage.listen((message) {

      if(Platform.isIOS){
        forgroundMessage();
      }

      if(Platform.isAndroid){
        initLocalNotifications(context, message);
        showNotification(message);
      }
    });
  }


  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true ,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('user granted permission');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print('user granted provisional permission');
      }
    } else {
      AppSettings.openAppSettings();
      if (kDebugMode) {
        print('user denied permission');
      }
    }
  }

  // function to show visible notification when app is active
  Future<void> showNotification(RemoteMessage message)async{

    AndroidNotificationChannel channel = const AndroidNotificationChannel(
        'ISMMART_ID',
      'ISMMART_NAME',
      // message.notification!.android!.channelId.toString(),
        // message.notification!.android!.channelId.toString() ,
        importance: Importance.max  ,
        showBadge: true ,
        playSound: true,
        // sound: const RawResourceAndroidNotificationSound('jetsons_doorbell')
    );

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        channel.id.toString(),
        channel.name.toString() ,
        channelDescription: 'your channel description',
        importance: Importance.high,
        priority: Priority.high ,
        playSound: true,
        ticker: 'ticker' ,
        sound: channel.sound
      //     sound: RawResourceAndroidNotificationSound('jetsons_doorbell')
      //  icon: largeIconPath
    );

    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
        presentAlert: true ,
        presentBadge: true ,
        presentSound: true
    ) ;

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: darwinNotificationDetails
    );

    Future.delayed(Duration.zero , (){
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification?.title.toString(),
        message.notification?.body.toString(),
        notificationDetails ,
      );
    });
    }

  //function to get device token on which we will send the notifications
  getDeviceToken() async {
    final token = await messaging.getToken();
    print(token);
    return token;
  }

  void isTokenRefresh() {
    messaging.onTokenRefresh.listen((event) async {
      event.toString();
      updateDeviceToken(event);
    });
  }

  updateDeviceToken(String fcmToken, {Map<String, dynamic>? data}) async {

    Map<String, dynamic> param;

    if(data != null) {
      param = {
        'fcm': fcmToken,
        'device[os]': data['device[os]'],
        'device[data]': data['device[device]']
      };
    } else {
      final deviceInfo = await GetStorage().read('deviceInfo');
      param = {
        'fcm': fcmToken,
        'device[os]': deviceInfo['device[os]'],
        'device[device]': deviceInfo['device[device]']
      };
    }

    ApiBaseHelper().putMethod(
        url: "${Urls.updateFcmToken}${param['device[device]']}",
        body: param);
  }

  //handle tap on notification when app is in background or terminated
  Future<void> setupInteractMessage(BuildContext context)async{

    // when app is terminated
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if(initialMessage != null){
      handleMessage(context, initialMessage);
    }


    //when app ins background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);

    });

  }

  void handleMessage(BuildContext context, RemoteMessage message) {

    if(message.data['type'] =='msj'){
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => MessageScreen(
      //       id: message.data['id'] ,
      //     )));
    }
  }


  Future forgroundMessage() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}