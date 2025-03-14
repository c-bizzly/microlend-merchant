import 'user_const.dart' as user_c;

import '../../../core/model.dart';
import '../../../core/const.dart' as c;

class BusinessModel implements Model {
  final String id;
  final String name;
  // TODO address id
  // TODO business_industry_id
  // TODO business image
  final String fkUserID;
  String? insertedAt;
  String? updatedAt;

  BusinessModel({
    required this.id,
    required this.name,
    required this.fkUserID,
    this.insertedAt,
    this.updatedAt,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> map) {
    return BusinessModel(
      id: map[c.id] as String,
      name: map[c.name] as String,
      fkUserID: map[user_c.fkUserID] as String,
      insertedAt: map[c.insertedAt] as String,
      updatedAt: map[c.updatedAt] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      c.id: id,
      c.name: name,
      user_c.fkUserID: fkUserID,
      c.insertedAt: insertedAt,
      c.updatedAt: updatedAt,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
