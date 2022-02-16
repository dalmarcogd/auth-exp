import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_training_notes/injection.dart';
import 'package:my_training_notes/models/user.dart';
import 'package:my_training_notes/screens/dashboard_screen.dart';
import 'package:my_training_notes/services/authentication/authentication.dart';
import 'package:my_training_notes/services/authentication/iauthentication.dart';
import 'package:my_training_notes/constants/custom_colors.dart';
import 'package:my_training_notes/widgets/google_sign_in_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();

  SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: const TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }

  onPressSignInGoogle(BuildContext context) {
    return () async {
      final Authentication authentication = locator.get<Authentication>();

      try {
        User? user = await authentication.signInWithGoogle(isWeb: kIsWeb);

        if (user != null) {
          Navigator.of(context).pushReplacement(createRoute(user));
        }
      } on AccountExistsWithDifferentCredentialException {
        ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(
            content: 'The account already exists with a different credential.',
          ),
        );
      } on InvalidCredentialException {
        ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(
            content: 'Error occurred while accessing credentials. Try again.',
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(
            content: 'Error occurred using Google Sign-In. Try again.',
          ),
        );
      }
    };
  }

  Route createRoute(User u) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          DashboardScreen(user: u),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Future<User?> onTrySignInSilently() async {
    final Authentication authentication = locator.get<Authentication>();
    return await authentication.signInWithGoogleSilently(isWeb: kIsWeb);
  }
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
        future: widget.onTrySignInSilently(),
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasData) {
            Future.delayed(const Duration(milliseconds: 1000)).then((value) => {
                  Navigator.of(context)
                      .pushReplacement(widget.createRoute(snapshot.data!))
                });

            return getBody(const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ));
          }

          return getBody(GoogleSignInButton(
              onPressed: widget.onPressSignInGoogle(context)));
        });
  }

  Scaffold getBody(Widget w) {
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
                      'My Training',
                      style: TextStyle(
                        color: CustomColors.firebaseYellow,
                        fontSize: 40,
                      ),
                    ),
                    const Text(
                      'Notes',
                      style: TextStyle(
                        color: CustomColors.firebaseOrange,
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
              ),
              w
            ],
          ),
        ),
      ),
    );
  }
}
