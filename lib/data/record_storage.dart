import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:are_you_ok/data/record_model.dart';

class RecordStorage {
  static const _key = 'records';

  Future<void> saveRecord(Record record) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> recordsJson = prefs.getStringList(_key) ?? [];
    recordsJson.add(jsonEncode(record.toJson()));
    print(recordsJson);
    await prefs.setStringList(_key, recordsJson);
  }

  Future<List<Record>> loadRecords() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> recordsJson = prefs.getStringList(_key) ?? [];
    return recordsJson
        .map((json) => Record.fromJson(jsonDecode(json)))
        .toList();
  }

  void clearRecords() {
    SharedPreferences.getInstance().then(
      (prefs) => prefs.remove(_key),
    );
  }
}
