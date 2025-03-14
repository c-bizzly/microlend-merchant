import 'user_const.dart' as user_c;

import '../../../core/model.dart';
import '../../../core/const.dart' as c;

class UserModel implements Model {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNumber;
  final String pinHash;
  // TODO user image
  String? insertedAt;
  String? updatedAt;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobileNumber,
    required this.pinHash,
    this.insertedAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map[c.id] as String,
      firstName: map[user_c.firstName] as String,
      lastName: map[user_c.lastName] as String,
      email: map[user_c.email] as String,
      mobileNumber: map[user_c.mobileNumber] as String,
      pinHash: map[user_c.pinHash] as String,
      insertedAt: map[c.insertedAt] as String,
      updatedAt: map[c.updatedAt] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      c.id: id,
      user_c.firstName: firstName,
      user_c.lastName: lastName,
      user_c.email: email,
      user_c.mobileNumber: mobileNumber,
      user_c.pinHash: pinHash,
      c.insertedAt: insertedAt,
      c.updatedAt: updatedAt,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
