import 'package:my_training_notes/models/user.dart';

abstract class Users {
  Future<User?> create(String firebaseUserUid, DateTime lastSignIn);
  Future<User?> update(User user);
  Future<User?> getByFirebaseUserUid(String firebaseUserUid);
}
