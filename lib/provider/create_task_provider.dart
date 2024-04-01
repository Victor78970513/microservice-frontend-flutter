import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateTaskProvider extends ChangeNotifier {
  List<dynamic> _users = [];
  List<dynamic> get users => _users;
  set users(List<dynamic> newUsers) {
    _users = newUsers;
    notifyListeners();
  }

  Future<void> fetchUsers() async {
    final resp = await http.get(Uri.parse("http://192.168.0.6:3000/personal"));
    users = jsonDecode(resp.body);
  }

  Future<bool> createTask({
    required int userId,
    required String taskName,
    required String description,
    required DateTime finishAt,
    required String taskState,
  }) async {
    try {
      final resp = await http.post(
        Uri.parse('http://192.168.0.6:3000/create-task'),
        body: {
          "userId": userId.toString(),
          "taskName": taskName,
          "description": description,
          "finishAt": finishAt.toString(),
          "taskState": taskState,
        },
      );
      if (resp.statusCode > 201) {
        return false;
      }
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
