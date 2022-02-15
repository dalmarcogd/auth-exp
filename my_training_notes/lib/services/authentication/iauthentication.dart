import 'package:my_training_notes/models/user.dart';

abstract class Authentication {
  Future<User?> signInWithGoogle({required bool isWeb});
  Future<void> signOut({required bool isWeb});
}
