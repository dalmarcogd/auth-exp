import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final String id;
  final String firebaseUserUid;
  final String? email;
  final String? displayName;
  final String? photoURL;
  final DateTime lastSignIn;

  const User({
    required this.id,
    required this.firebaseUserUid,
    required this.email,
    required this.displayName,
    required this.photoURL,
    required this.lastSignIn,
  });

  User updateLastSignIn(DateTime d) {
    return User(
        id: id,
        firebaseUserUid: firebaseUserUid,
        email: email,
        displayName: displayName,
        photoURL: photoURL,
        lastSignIn: d);
  }

  @override
  List<Object?> get props =>
      [id, firebaseUserUid, email, displayName, photoURL, lastSignIn];

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
