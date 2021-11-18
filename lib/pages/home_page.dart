import 'package:flutter/material.dart';
import '../components/tasklist.dart';
import 'package:provider/provider.dart';
import '../components/task.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'TIG169 TODO',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
          ),
          centerTitle: true,
          backgroundColor: Colors.amberAccent,
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amberAccent,
          onPressed: () {
            Navigator.pushNamed(context, '/addtask');
          },
          child: const Icon(
            Icons.add,
            size: 30,
            color: Colors.black,
          ),
        ),
        body: Consumer<MyState>(
            builder: (context, value, child) => value.getTasks.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [Text('No Added Tasks')],
                    ),
                  )
                : TaskList(
                    value.getTasks,
                  )));
  }
}

class MyState with ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get getTasks => _tasks;

  onDelete(task) {
    _tasks.remove(task);
    notifyListeners();
  }

  addTask(task) {
    _tasks.add(Task(text: task));
    notifyListeners();
  }

  setCheck(value, task) {
    task.checkBoxValue = value;
    notifyListeners();
  }

  String _textField = "";
  final _formKey = GlobalKey<FormState>();

  String get getTextField => _textField;

  GlobalKey<FormState> get getFormKey => _formKey;

  bool textFieldIsEmpty(String textField) {
    return textField.isEmpty;
  }

  setTextField(todo) {
    _textField = todo;
  }

  validateFormState() {
    return _formKey.currentState!.validate();
  }
}
