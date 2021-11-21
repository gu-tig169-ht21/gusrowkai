import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/add_task_page.dart';
import 'package:provider/provider.dart';
import '../pages/home_page.dart';
import './services/internet.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => MyState(),
    child: MaterialApp(
      routes: {
        '/': (context) => HomePage(),
        '/addtask': (context) => AddTaskPage()
      },
      debugShowCheckedModeBanner: false,
    ),
  ));
}

class MyState with ChangeNotifier {
  MyState() {
    loadTasks();
  }

  List<dynamic> _taskList = [];

  get taskList => _taskList;

  String _apiKey = "c20377c7-9daf-4efb-ba59-3f07b7259943";

  getApiKey() async {
    _apiKey = await Internet.fetchApiKey();
    loadTasks();
  }

  loadTasks() async {
    var response = await Internet.performGetRequest(_apiKey);
    _taskList = response;
    _renderTaskList = _taskList;
    notifyListeners();
  }

  addTask(textInputValue) async {
    var response = await Internet.performPostRequest(textInputValue, _apiKey);
    _taskList = response;

    notifyListeners();

    renderFilterOption();
  }

  changeCheckBoxValue(checkValue, taskIndex) async {
    var taskToBeUpdatedID = _renderTaskList[taskIndex]['id'];
    var taskToBeUpdatedTextfield = _renderTaskList[taskIndex]['title'];
    var response = await Internet.performPutRequest(
        taskToBeUpdatedTextfield, checkValue, taskToBeUpdatedID, _apiKey);

    _taskList = response;

    notifyListeners();

    renderFilterOption();
  }

  deleteTask(taskIndex) async {
    var taskToBeRemovedID = _renderTaskList[taskIndex]['id'];
    var response =
        await Internet.performDeleteRequest(taskToBeRemovedID, _apiKey);
    _taskList = response;

    notifyListeners();

    renderFilterOption();
  }

  String _textField = "";

  String get getTextField => _textField;

  final _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get getFormKey => _formKey;

  bool textFieldIsEmpty(String textField) {
    return textField.isEmpty;
  }

  setTextField(textInput) {
    _textField = textInput;
  }

  validateFormState() {
    return _formKey.currentState!.validate();
  }

  setFilterOption(filterValue) {
    if (filterValue == 'all') {
      _filterValue = 'all';
    } else if (filterValue == 'done') {
      _filterValue = 'done';
    } else if (filterValue == 'undone') {
      _filterValue = 'undone';
    }

    renderFilterOption();
  }

  renderFilterOption() {
    if (_filterValue == 'all') {
      _renderTaskList = _taskList;
    } else if (_filterValue == 'done') {
      _renderTaskList =
          _taskList.where((element) => element['done'] == true).toList();
    } else if (_filterValue == 'undone') {
      _renderTaskList =
          _taskList.where((element) => element['done'] == false).toList();
    }

    notifyListeners();
  }

  String _filterValue = "all";

  get filterValue => _filterValue;

  List<dynamic> _renderTaskList = [];

  get renderTaskList => _renderTaskList;
}
