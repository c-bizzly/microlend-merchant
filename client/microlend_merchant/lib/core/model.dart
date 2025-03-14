abstract class Model<T> {
  Map<String, dynamic> toJson();

  Model.fromJson(Map<String, Object?> map);
}
