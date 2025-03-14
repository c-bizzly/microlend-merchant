import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'app.dart';

void main() {
  debugPrint(DateTime.now().toUtc().toString());
  var uuid = Uuid();
  var uuidV4 = uuid.v4(); // Generate a v4 UUID
  debugPrint('Generated UUID: $uuidV4');

  runApp(const App());
}
