import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class FirebaseService {
  late FirebaseApp firebaseApp;
  late FirebaseFirestore firebaseFirestore;
  late FirebaseAuth firebaseAuth;

  static Future<FirebaseService> init() async {
    FirebaseService firebaseService = FirebaseService();
    FirebaseOptions? firebaseOptions;

    if (kIsWeb) {
      firebaseOptions = const FirebaseOptions(
          apiKey: "AIzaSyCvFLcrm797JXKBjNzAbxbBzglRhifQPzI",
          authDomain: "my-training-notes.firebaseapp.com",
          projectId: "my-training-notes",
          storageBucket: "my-training-notes.appspot.com",
          messagingSenderId: "775118130907",
          appId: "1:775118130907:web:92bf8afb3a28ea9ed5c6fe",
          measurementId: "G-XHBYNN68E2");
    } else {
      switch (Platform.operatingSystem) {
        case "ios":
        case "macos":
          firebaseOptions = const FirebaseOptions(
            apiKey: "AIzaSyBv_oHsX7c1WhJMDbWRfWFizH-por3kaDM",
            appId: "1:775118130907:ios:e4aafc91ea6f94e6d5c6fe",
            messagingSenderId: "775118130907",
            projectId: "my-training-notes",
            iosBundleId: "com.my-training-notes.app",
            iosClientId:
                "775118130907-rb0gr2u06mfa1vg082iv39v9f1jtgjdl.apps.googleusercontent.com",
          );
          break;
        case "android":
          firebaseOptions = const FirebaseOptions(
            apiKey: "AIzaSyCEri3mmL2hsDXHyXNJcjODM3QfZOICzBM",
            appId: "1:775118130907:android:0b89931c1f32c411d5c6fe",
            messagingSenderId: "775118130907",
            projectId: "my-training-notes",
            androidClientId:
                "775118130907-ee497e9oblls3sibubj4jvni8qskaefl.apps.googleusercontent.com",
          );
          break;
      }
    }

    firebaseService.firebaseApp =
        await Firebase.initializeApp(options: firebaseOptions);
    firebaseService.firebaseFirestore = FirebaseFirestore.instance;
    firebaseService.firebaseAuth = FirebaseAuth.instance;

    return firebaseService;
  }
}
