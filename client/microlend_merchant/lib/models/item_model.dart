import 'item_const.dart' as item_c;

import '../../../core/model.dart';
import '../../../core/const.dart' as c;

class ItemModel implements Model {
  final String id;
  final String name;
  final String sku;
  // TODO: data type
  final String salePrice;
  String insertedAt;
  String? updatedAt;

  ItemModel({
    required this.id,
    required this.name,
    required this.sku,
    required this.salePrice,
    required this.insertedAt,
    this.updatedAt,
  });

  factory ItemModel.fromJson(Map<String, dynamic> map) {
    return ItemModel(
      id: map[c.id] as String,
      name: map[c.name] as String,
      sku: map[item_c.sku] as String,
      salePrice: map[item_c.salePrice] as String,
      insertedAt: map[c.insertedAt] as String,
      updatedAt: map[c.updatedAt] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      c.id: id,
      c.name: name,
      item_c.sku: sku,
      item_c.salePrice: salePrice,
      c.insertedAt: insertedAt,
      c.updatedAt: updatedAt,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
