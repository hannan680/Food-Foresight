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
    apiKey: 'AIzaSyCnQ00DFkoXy1RjzD_dVbMbiUm-AHyVD_4',
    appId: '1:656300033002:web:eebbca169611d4545aa893',
    messagingSenderId: '656300033002',
    projectId: 'food-foresight',
    authDomain: 'food-foresight.firebaseapp.com',
    storageBucket: 'food-foresight.appspot.com',
    measurementId: 'G-Z5XHC1ZS0Y',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAt85hsclYRdXNyHlSq5q1298gVKUq6QhI',
    appId: '1:656300033002:android:5aff39a038680b1a5aa893',
    messagingSenderId: '656300033002',
    projectId: 'food-foresight',
    storageBucket: 'food-foresight.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBBmgtE6Rx_yHL4U6e6dbqGOxfAb_6Fu3E',
    appId: '1:656300033002:ios:36921a43a1bdf8025aa893',
    messagingSenderId: '656300033002',
    projectId: 'food-foresight',
    storageBucket: 'food-foresight.appspot.com',
    iosClientId: '656300033002-l71vvk53ttuomeigrltb935f62o7m8ok.apps.googleusercontent.com',
    iosBundleId: 'com.example.foodForesight',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBBmgtE6Rx_yHL4U6e6dbqGOxfAb_6Fu3E',
    appId: '1:656300033002:ios:d61a3adc31d89a4f5aa893',
    messagingSenderId: '656300033002',
    projectId: 'food-foresight',
    storageBucket: 'food-foresight.appspot.com',
    iosClientId: '656300033002-g0rma8ktgf0n4eips89b1uajrperobcg.apps.googleusercontent.com',
    iosBundleId: 'com.example.foodForesight.RunnerTests',
  );
}