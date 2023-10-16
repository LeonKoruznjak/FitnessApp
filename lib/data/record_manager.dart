import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecordManager {
  static const String _recordsKey = 'records';

  static Future<List<Map<String, dynamic>>> getRecords() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_recordsKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.cast<Map<String, dynamic>>();
    }
    return [];
  }

  static Future<void> saveRecord(List<Map<String, dynamic>> records) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> recordsWithDateString = records.map((record) {
      final String dateString = record['date'].toString();
      return {
        ...record,
        'date': dateString,
      };
    }).toList();
    final jsonString = jsonEncode(recordsWithDateString);
    prefs.setString(_recordsKey, jsonString);
  }
}