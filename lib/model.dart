import 'package:flutter/material.dart';
import './services/internet.dart';

class MyState with ChangeNotifier {
  MyState() {
    loadTasks();
  }

  var _turnary = true;

  get turnary => _turnary;

  set setTurnary(value) {
    _turnary = value;
  }

  var _loadingPhase = true;

  get loadingPhase => _loadingPhase;

  List<dynamic> _taskList = [];

  get taskList => _taskList;

  //create load page
  bool _loadFail = false;

  get loadFail => _loadFail;

  bool _addFail = false;

  get addFail => _addFail;

  bool _updateFail = false;

  get updateFail => _updateFail;

  bool _deleteFail = false;

  get deleteFail => _deleteFail;

  String _successStatus = '';

  get successStatus => _successStatus;

  String _apiKey = "c20377c7-9daf-4efb-ba59-3f07b7259943";

  getApiKey() async {
    _apiKey = await Internet.fetchApiKey();
    loadTasks();
  }

  loadTasks() async {
    var response = await Internet.performGetRequest(_apiKey);

    if (response.runtimeType == String) {
      _loadFail == true;

      _successStatus = response;

      notifyListeners();
    }

    _loadingPhase = false;

    _taskList = response;

    _renderTaskList = _taskList;

    _successStatus = 'Successfully Fetched Items!';

    notifyListeners();
  }

  addTask(textInputValue) async {
    var response = await Internet.performPostRequest(textInputValue, _apiKey);

    if (response.runtimeType == String) {
      _successStatus = response;

      _addFail = true;

      notifyListeners();
    }

    _taskList = response;

    _successStatus = 'Successfully Added Item!';

    notifyListeners();

    renderFilterOption();
  }

  changeCheckBoxValue(checkValue, taskIndex) async {
    var taskToBeUpdatedID = _renderTaskList[taskIndex]['id'];
    var taskToBeUpdatedTextfield = _renderTaskList[taskIndex]['title'];
    var response = await Internet.performPutRequest(
        taskToBeUpdatedTextfield, checkValue, taskToBeUpdatedID, _apiKey);

    if (response.runtimeType == String) {
      _successStatus = response;

      _updateFail = true;

      notifyListeners();
    }

    _taskList = response;

    _successStatus = 'Successfully Updated Item!';

    notifyListeners();

    renderFilterOption();
  }

  deleteTask(taskIndex) async {
    var taskToBeRemovedID = _renderTaskList[taskIndex]['id'];

    var response =
        await Internet.performDeleteRequest(taskToBeRemovedID, _apiKey);

    if (response.runtimeType == String) {
      _successStatus = response;

      _deleteFail = true;

      notifyListeners();
    }

    _taskList = response;

    _successStatus = 'Successfully Deleted Item!';

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
