// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAaJKYPHcVaSauVP14-LiRu_mb8ms-TKiU',
    appId: '1:517574266791:web:9e96e4b9139965fd487082',
    messagingSenderId: '517574266791',
    projectId: 'messaging-app-2e9e1',
    authDomain: 'messaging-app-2e9e1.firebaseapp.com',
    storageBucket: 'messaging-app-2e9e1.appspot.com',
    measurementId: 'G-MWZ87CSZ7V',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB44ZGmyEPNtO85hlk0xm-gfu38rn__Q_0',
    appId: '1:517574266791:android:ccc14d5f26f3b4b1487082',
    messagingSenderId: '517574266791',
    projectId: 'messaging-app-2e9e1',
    storageBucket: 'messaging-app-2e9e1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyApqy9XRtlYueCMCIPtDpPMn6hr_2N3mSw',
    appId: '1:517574266791:ios:74f675deb3a20527487082',
    messagingSenderId: '517574266791',
    projectId: 'messaging-app-2e9e1',
    storageBucket: 'messaging-app-2e9e1.appspot.com',
    iosClientId: '517574266791-cgb4as7qumspkqiqe5od7s2i2o9cv68o.apps.googleusercontent.com',
    iosBundleId: 'com.example.messagingInFirebase',
  );
}
