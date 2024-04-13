import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC7Ne-dvGauVhw-6ZgDL0flQfpoAWeYaAY',
    appId: '1:1027002047166:web:2dc6a79ea89c88525a9cef',
    messagingSenderId: '1027002047166',
    projectId: 'software-engineering-pro-e850e',
    authDomain: 'software-engineering-pro-e850e.firebaseapp.com',
    storageBucket: 'software-engineering-pro-e850e.appspot.com',
    measurementId: 'G-Y4KF6G2PR8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDtStlLwIR8r6vbfQNGG5EvmMYGIbYWmuQ',
    appId: '1:1027002047166:android:5ba71e2ecd8505925a9cef',
    messagingSenderId: '1027002047166',
    projectId: 'software-engineering-pro-e850e',
    storageBucket: 'software-engineering-pro-e850e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCHJpO9AjxL36FeKFibPA_cAJkMxJ99HzU',
    appId: '1:1027002047166:ios:86002ebad4b266ec5a9cef',
    messagingSenderId: '1027002047166',
    projectId: 'software-engineering-pro-e850e',
    storageBucket: 'software-engineering-pro-e850e.appspot.com',
    iosBundleId: 'com.example.softwareEngineeringProjectFlutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCHJpO9AjxL36FeKFibPA_cAJkMxJ99HzU',
    appId: '1:1027002047166:ios:3af5d91f746621595a9cef',
    messagingSenderId: '1027002047166',
    projectId: 'software-engineering-pro-e850e',
    storageBucket: 'software-engineering-pro-e850e.appspot.com',
    iosBundleId: 'com.example.softwareEngineeringProjectFlutter.RunnerTests',
  );
}
