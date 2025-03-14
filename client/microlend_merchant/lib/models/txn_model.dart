import 'txn_const.dart' as txn_c;
import 'business_const.dart' as business_c;

import '../../../core/model.dart';
import '../../../core/const.dart' as c;

class TxnModel implements Model {
  final String id;
  final double totalPrice;
  final String fkBusinessID;
  String? insertedAt;
  String? updatedAt;

  TxnModel({
    required this.id,
    required this.totalPrice,
    required this.fkBusinessID,
    this.insertedAt,
    this.updatedAt,
  });

  factory TxnModel.fromJson(Map<String, dynamic> map) {
    return TxnModel(
      id: map[c.id] as String,
      totalPrice: map[txn_c.totalPrice] as double,
      fkBusinessID: map[business_c.fkBusinessID] as String,
      insertedAt: map[c.insertedAt] as String,
      updatedAt: map[c.updatedAt] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      c.id: id,
      txn_c.totalPrice: totalPrice,
      c.insertedAt: insertedAt,
      c.updatedAt: updatedAt,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
