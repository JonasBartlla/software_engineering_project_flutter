import 'package:firebase_messaging/firebase_messaging.dart';


Future<void> handleBackgroundMessage(RemoteMessage message) async{
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Title: ${message.data}');
}

class FirebaseApi {
  final firebaseMessaging = FirebaseMessaging.instance;

  void handleMessage (RemoteMessage? message){
    if (message == null) return; //hier muss noch angepasst werden, wohin navigiert werden soll
  }

  Future initPushNotifications() async{ //die Funktion muss dann auf Home aufgerufen werden
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null){
      handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    //FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<void> initNotifications() async{
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
    final fCMToken = await firebaseMessaging.getToken(vapidKey: "BGDIXeyOmhM29_CgNE0FpJSpxL8pC7G97NKbORyuRhiMdygSAaUFpq-AkMu330j3H-HXTsLHDDOePtdV6UVc9l4");
    print('Token: $fCMToken');
    FirebaseMessaging.instance.onTokenRefresh.listen((fCMToken){

    }).onError((err){

    });
    initPushNotifications();
  }



}