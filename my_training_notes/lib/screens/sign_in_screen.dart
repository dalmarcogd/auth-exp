import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_training_notes/injection.dart';
import 'package:my_training_notes/models/user.dart';
import 'package:my_training_notes/screens/home_screen.dart';
import 'package:my_training_notes/services/authentication/iauthentication.dart';
import 'package:my_training_notes/constants/custom_colors.dart';
import 'package:my_training_notes/widgets/google_sign_in_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.firebaseNavy,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Image.asset(
                        'assets/images/firebase_logo.png',
                        height: 160,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'FlutterFire',
                      style: TextStyle(
                        color: CustomColors.firebaseYellow,
                        fontSize: 40,
                      ),
                    ),
                    const Text(
                      'Authentication',
                      style: TextStyle(
                        color: CustomColors.firebaseOrange,
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
              ),
              GoogleSignInButton(onPressed: () async {
                final Authentication authentication =
                    locator.get<Authentication>();

                User? user =
                    await authentication.signInWithGoogle(isWeb: kIsWeb);

                if (user != null) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(
                        user: user,
                      ),
                    ),
                  );
                }
              })
              // FutureBuilder(
              //   future: Authentication.initializeFirebase(context: context),
              //   builder: (context, snapshot) {
              //     if (snapshot.hasError) {
              //       return Text(
              //           'Error initializing Firebase: ${snapshot.error}');
              //     } else if (snapshot.connectionState == ConnectionState.done) {
              //       return GoogleSignInButton(onPressed: () async {
              //         final Authentication authentication =
              //             locator.get<Authentication>();

              //         User? user =
              //             await authentication.signInWithGoogle(isWeb: kIsWeb);

              //         if (user != null) {
              //           Navigator.of(context).pushReplacement(
              //             MaterialPageRoute(
              //               builder: (context) => HomeScreen(
              //                 user: user,
              //               ),
              //             ),
              //           );
              //         }
              //       });
              //     }
              //     return const CircularProgressIndicator(
              //       valueColor: AlwaysStoppedAnimation<Color>(
              //         CustomColors.firebaseOrange,
              //       ),
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
