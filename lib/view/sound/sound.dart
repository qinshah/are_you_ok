import 'dart:convert';

import 'package:flutter/services.dart';

class Sound {
  Sound._();

  static Sound instance = Sound._();

  factory Sound() => instance;

  late String current;
  List<String> paths = [];

  Future<void> init() async {
    var manifestContent = await rootBundle.loadString('AssetManifest.json');
    Map<String, dynamic> manifestMap = jsonDecode(manifestContent);
    paths = manifestMap.keys.where((key) {
      return key.startsWith('assets/sound');
    }).toList();
    current = paths.first;
  }
}
