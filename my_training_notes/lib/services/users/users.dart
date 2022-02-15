import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import 'package:my_training_notes/models/user.dart';
import 'package:my_training_notes/services/users/iusers.dart';
import 'package:my_training_notes/utils/firebase.dart';
import 'package:uuid/uuid.dart';

class UserNotFoundByFirebaseUserUidExeception implements Exception {
  UserNotFoundByFirebaseUserUidExeception();
}

@Injectable(as: Users)
class UsersImpl implements Users {
  late CollectionReference<Map<String, dynamic>> collection;
  final FirebaseService firebaseService;

  UsersImpl({
    required this.firebaseService,
  }) {
    collection = firebaseService.firebaseFirestore.collection("users");
  }

  @override
  Future<User?> create(String firebaseUserUid, DateTime lastSignIn) async {
    var uuid = const Uuid();
    User user = User(
        id: uuid.v4(),
        firebaseUserUid: firebaseUserUid,
        lastSignIn: lastSignIn);
    await collection.doc(user.id).set(user.toJson());
    return user;
  }

  @override
  Future<User?> update(User user) async {
    await collection.doc(user.id).set(user.toJson());
    return user;
  }

  @override
  Future<User?> getByFirebaseUserUid(String firebaseUserUid) async {
    QuerySnapshot<Map<String, dynamic>> result = await collection
        .where("firebaseUserUid", isEqualTo: firebaseUserUid)
        .get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = result.docs;
    if (docs.isNotEmpty) {
      User u = User.fromJson(docs.first.data());
      if (u.id.isNotEmpty) {
        return u;
      }
    }

    throw UserNotFoundByFirebaseUserUidExeception();
  }
}
