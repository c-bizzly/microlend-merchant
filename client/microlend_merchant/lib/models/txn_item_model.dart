import 'txn_item_const.dart' as txn_item_c;
import 'txn_const.dart' as txn_c;

import '../../../core/model.dart';
import '../../../core/const.dart' as c;

class TxnItemModel implements Model {
  final String id;
  final int quantity;
  final String fkTransactionID;
  String? insertedAt;
  String? updatedAt;

  TxnItemModel({
    required this.id,
    required this.quantity,
    required this.fkTransactionID,
    this.insertedAt,
    this.updatedAt,
  });

  factory TxnItemModel.fromJson(Map<String, dynamic> map) {
    return TxnItemModel(
      id: map[c.id] as String,
      quantity: map[txn_item_c.quantity] as int,
      fkTransactionID: map[txn_c.fkTransactionID] as String,
      insertedAt: map[c.insertedAt] as String,
      updatedAt: map[c.updatedAt] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      c.id: id,
      txn_item_c.quantity: quantity,
      txn_c.fkTransactionID: fkTransactionID,
      c.insertedAt: insertedAt,
      c.updatedAt: updatedAt,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
