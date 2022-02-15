// import 'dart:io';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:my_training_notes/screens/home_screen.dart';

// class Authentication {
//   static Future<FirebaseApp> initializeFirebase({
//     required BuildContext context,
//   }) async {
//     FirebaseOptions? firebaseOptions;

//     if (kIsWeb) {
//       firebaseOptions = const FirebaseOptions(
//           apiKey: "AIzaSyCvFLcrm797JXKBjNzAbxbBzglRhifQPzI",
//           authDomain: "my-training-notes.firebaseapp.com",
//           projectId: "my-training-notes",
//           storageBucket: "my-training-notes.appspot.com",
//           messagingSenderId: "775118130907",
//           appId: "1:775118130907:web:92bf8afb3a28ea9ed5c6fe",
//           measurementId: "G-XHBYNN68E2");
//     } else {
//       switch (Platform.operatingSystem) {
//         case "ios":
//         case "macos":
//           firebaseOptions = const FirebaseOptions(
//             apiKey: "AIzaSyBv_oHsX7c1WhJMDbWRfWFizH-por3kaDM",
//             appId: "1:775118130907:ios:e4aafc91ea6f94e6d5c6fe",
//             messagingSenderId: "775118130907",
//             projectId: "my-training-notes",
//             iosBundleId: "com.my-training-notes.app",
//             iosClientId:
//                 "775118130907-rb0gr2u06mfa1vg082iv39v9f1jtgjdl.apps.googleusercontent.com",
//           );
//           break;
//         case "android":
//           firebaseOptions = const FirebaseOptions(
//             apiKey: "AIzaSyCEri3mmL2hsDXHyXNJcjODM3QfZOICzBM",
//             appId: "1:775118130907:android:0b89931c1f32c411d5c6fe",
//             messagingSenderId: "775118130907",
//             projectId: "my-training-notes",
//             androidClientId:
//                 "775118130907-ee497e9oblls3sibubj4jvni8qskaefl.apps.googleusercontent.com",
//           );
//           break;
//       }
//     }

//     FirebaseApp firebaseApp =
//         await Firebase.initializeApp(options: firebaseOptions);

//     User? user = FirebaseAuth.instance.currentUser;

//     if (user != null) {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (context) => HomeScreen(
//             user: user,
//           ),
//         ),
//       );
//     }

//     return firebaseApp;
//   }

//   static SnackBar customSnackBar({required String content}) {
//     return SnackBar(
//       backgroundColor: Colors.black,
//       content: Text(
//         content,
//         style: const TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
//       ),
//     );
//   }

//   static Future<User?> signInWithGoogle({required BuildContext context}) async {
//     FirebaseAuth auth = FirebaseAuth.instance;
//     User? user;

//     if (kIsWeb) {
//       GoogleAuthProvider authProvider = GoogleAuthProvider();

//       try {
//         final UserCredential userCredential =
//             await auth.signInWithPopup(authProvider);

//         user = userCredential.user;
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           Authentication.customSnackBar(
//             content: 'Something wen wrong: $e',
//           ),
//         );
//       }
//     } else {
//       final GoogleSignIn googleSignIn = GoogleSignIn();

//       final GoogleSignInAccount? googleSignInAccount =
//           await googleSignIn.signIn();

//       if (googleSignInAccount != null) {
//         final GoogleSignInAuthentication googleSignInAuthentication =
//             await googleSignInAccount.authentication;

//         final AuthCredential credential = GoogleAuthProvider.credential(
//           accessToken: googleSignInAuthentication.accessToken,
//           idToken: googleSignInAuthentication.idToken,
//         );

//         try {
//           final UserCredential userCredential =
//               await auth.signInWithCredential(credential);

//           user = userCredential.user;
//         } on FirebaseAuthException catch (e) {
//           if (e.code == 'account-exists-with-different-credential') {
//             ScaffoldMessenger.of(context).showSnackBar(
//               Authentication.customSnackBar(
//                 content:
//                     'The account already exists with a different credential.',
//               ),
//             );
//           } else if (e.code == 'invalid-credential') {
//             ScaffoldMessenger.of(context).showSnackBar(
//               Authentication.customSnackBar(
//                 content:
//                     'Error occurred while accessing credentials. Try again.',
//               ),
//             );
//           }
//         } catch (e) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             Authentication.customSnackBar(
//               content: 'Error occurred using Google Sign-In. Try again.',
//             ),
//           );
//         }
//       }
//     }

//     return user;
//   }

//   static Future<void> signOut({required BuildContext context}) async {
//     final GoogleSignIn googleSignIn = GoogleSignIn();

//     try {
//       if (!kIsWeb) {
//         await googleSignIn.signOut();
//       }
//       await FirebaseAuth.instance.signOut();
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         Authentication.customSnackBar(
//           content: 'Error signing out. Try again.',
//         ),
//       );
//     }
//   }
// }
