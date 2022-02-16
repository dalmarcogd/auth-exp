import 'package:my_training_notes/models/user.dart';

abstract class Users {
  Future<User?> create(String firebaseUserUid, String email, String displayName,
      String photoURL, DateTime lastSignIn);
  Future<User?> update(User user);
  Future<User?> getByFirebaseUserUid(String firebaseUserUid);
}
