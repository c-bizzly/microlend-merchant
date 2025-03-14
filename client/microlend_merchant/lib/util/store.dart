import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show Platform;

Future<void> saveData(String key, String value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

Future<String?> getData(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

Future<String> getStoragePath() async {
  if (Platform.isAndroid || Platform.isIOS) {
    // Use the method for mobile
    return (await getApplicationDocumentsDirectory()).path;
  } else {
    // Use shared_preferences for web
    return "web_storage_path"; // Or some fallback mechanism
  }
}
