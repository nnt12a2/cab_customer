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
    apiKey: 'AIzaSyARMbR7KaZRJ6URFgSVIletX4bj6bSceSc',
    appId: '1:413742952325:web:38d70d460433f29a3adeec',
    messagingSenderId: '413742952325',
    projectId: 'taxi-d8272',
    authDomain: 'taxi-d8272.firebaseapp.com',
    storageBucket: 'taxi-d8272.appspot.com',
    measurementId: 'G-XF84K8L2JM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC9-5lbmI6S9ik5VNb-6nsecDPfrTbth1I',
    appId: '1:413742952325:android:eb616f73b87983e63adeec',
    messagingSenderId: '413742952325',
    projectId: 'taxi-d8272',
    storageBucket: 'taxi-d8272.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCQiwTmVqyLFUXKF1cSAtTGZ3gX1hgmmuM',
    appId: '1:413742952325:ios:09f56f246f09cb7a3adeec',
    messagingSenderId: '413742952325',
    projectId: 'taxi-d8272',
    storageBucket: 'taxi-d8272.appspot.com',
    androidClientId: '413742952325-1lfh1geqem19242388uabj964b1j16ik.apps.googleusercontent.com',
    iosClientId: '413742952325-neumef3a70me1b107rem9s8h1o3b619i.apps.googleusercontent.com',
    iosBundleId: 'com.ex.cabme.ios',
  );
}