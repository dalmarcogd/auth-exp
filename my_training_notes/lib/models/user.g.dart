// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      firebaseUserUid: json['firebaseUserUid'] as String,
      lastSignIn: DateTime.parse(json['lastSignIn'] as String),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'firebaseUserUid': instance.firebaseUserUid,
      'lastSignIn': instance.lastSignIn.toIso8601String(),
    };
