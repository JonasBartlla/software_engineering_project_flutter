import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async{
    await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    final fCMToken = await firebaseMessaging.getToken(vapidKey: "BGDIXeyOmhM29_CgNE0FpJSpxL8pC7G97NKbORyuRhiMdygSAaUFpq-AkMu330j3H-HXTsLHDDOePtdV6UVc9l4");
    print('Token: $fCMToken');
  }

}