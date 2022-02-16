import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:my_training_notes/models/user.dart';
import 'package:my_training_notes/services/authentication/iauthentication.dart';
import 'package:my_training_notes/services/users/iusers.dart';
import 'package:my_training_notes/services/users/users.dart';
import 'package:my_training_notes/utils/firebase.dart';
import 'package:uuid/uuid.dart';

class AccountExistsWithDifferentCredentialException implements Exception {
  AccountExistsWithDifferentCredentialException();
}

class InvalidCredentialException implements Exception {
  InvalidCredentialException();
}

class InternalException implements Exception {
  InternalException();
}

@Injectable(as: Authentication)
class AuthenticationImpl implements Authentication {
  final FirebaseService firebaseService;
  final Users users;

  AuthenticationImpl(this.firebaseService, this.users);

  @override
  Future<User?> signInWithGoogle({required bool isWeb}) async {
    fb.User? firebaseUser;

    if (isWeb) {
      fb.GoogleAuthProvider authProvider = fb.GoogleAuthProvider();

      final fb.UserCredential userCredential =
          await firebaseService.firebaseAuth.signInWithPopup(authProvider);

      firebaseUser = userCredential.user;
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final fb.AuthCredential credential = fb.GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final fb.UserCredential userCredential = await firebaseService
              .firebaseAuth
              .signInWithCredential(credential);

          firebaseUser = userCredential.user;
        } on fb.FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            throw AccountExistsWithDifferentCredentialException();
          } else if (e.code == 'invalid-credential') {
            throw InvalidCredentialException();
          }
        } catch (e) {
          throw InternalException();
        }
      }
    }

    String? firebaseUserUid = firebaseUser?.uid;
    String? firebaseUserEmail = firebaseUser?.email;
    String? firebaseUserDisplayName = firebaseUser?.displayName;
    String? firebaseUserPhotoURL = firebaseUser?.photoURL;
    User? user;
    try {
      user = await users.getByFirebaseUserUid(firebaseUserUid!);
    } on UserNotFoundByFirebaseUserUidExeception {
      user = await users.create(firebaseUserUid!, firebaseUserEmail!,
          firebaseUserDisplayName!, firebaseUserPhotoURL!, DateTime.now());
    }

    user = user?.updateLastSignIn(DateTime.now());
    user = await users.update(user!);

    return user;
  }

  @override
  Future<User?> signInWithGoogleSilently({required bool isWeb}) async {
    fb.User? firebaseUser;

    if (isWeb) {
      fb.GoogleAuthProvider authProvider = fb.GoogleAuthProvider();

      final fb.UserCredential userCredential =
          await firebaseService.firebaseAuth.signInWithPopup(authProvider);

      firebaseUser = userCredential.user;
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signInSilently();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final fb.AuthCredential credential = fb.GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final fb.UserCredential userCredential = await firebaseService
              .firebaseAuth
              .signInWithCredential(credential);

          firebaseUser = userCredential.user;
        } on fb.FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            throw AccountExistsWithDifferentCredentialException();
          } else if (e.code == 'invalid-credential') {
            throw InvalidCredentialException();
          }
        } catch (e) {
          throw InternalException();
        }
      }
    }

    String? firebaseUserUid = firebaseUser?.uid;
    String? firebaseUserEmail = firebaseUser?.email;
    String? firebaseUserDisplayName = firebaseUser?.displayName;
    String? firebaseUserPhotoURL = firebaseUser?.photoURL;
    User? user;
    try {
      user = await users.getByFirebaseUserUid(firebaseUserUid!);
    } on UserNotFoundByFirebaseUserUidExeception {
      user = await users.create(firebaseUserUid!, firebaseUserEmail!,
          firebaseUserDisplayName!, firebaseUserPhotoURL!, DateTime.now());
    }

    user = user?.updateLastSignIn(DateTime.now());
    user = await users.update(user!);

    return user;
  }

  @override
  Future<void> signOut({required bool isWeb}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    if (!isWeb) {
      await googleSignIn.signOut();
    }

    await firebaseService.firebaseAuth.signOut();
  }
}
