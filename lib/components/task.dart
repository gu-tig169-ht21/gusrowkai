import 'package:flutter/material.dart';

class Task {
  String text;
  bool checkBoxValue = false;

  Task({required this.text});
}

class TaskState with ChangeNotifier {
  setCheck(value, task) {
    task.checkBoxValue = value;
    notifyListeners();
  }
}
