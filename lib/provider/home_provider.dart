import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeProvider extends ChangeNotifier {
  List<dynamic> _tasks = [];

  List<dynamic> get tasks => _tasks;
  set tasks(List<dynamic> data) {
    _tasks = data;
    notifyListeners();
  }

  Future<void> getTasks() async {
    try {
      final resp = await http.get(Uri.parse('http://192.168.0.6:3000/tasks'));

      if (resp.statusCode == 200 || resp.statusCode == 201) {
        log(resp.body);
        tasks = jsonDecode(resp.body);
      } else {
        log("HUBO UN ERROR CHOQUITO");
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
