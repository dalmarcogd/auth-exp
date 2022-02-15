import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final String id;
  final String firebaseUserUid;
  final DateTime lastSignIn;

  const User({
    required this.id,
    required this.firebaseUserUid,
    required this.lastSignIn,
  });

  User updateLastSignIn(DateTime d) {
    return User(id: id, firebaseUserUid: firebaseUserUid, lastSignIn: d);
  }

  @override
  List<Object?> get props => [id, firebaseUserUid, lastSignIn];

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
