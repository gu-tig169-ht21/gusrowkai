import 'package:flutter/material.dart';
import 'package:my_first_app/pages/home_page.dart';
import 'home_page.dart';
import 'package:provider/provider.dart';

class AddTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('add task page built');
    var homePageState = Provider.of<HomePageState>(context);
    var addTaskProvider = Provider.of<AddTaskPageState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
        centerTitle: true,
        backgroundColor: Colors.green[300],
      ),
      body: Form(
        key: addTaskProvider.getFormKey,
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(30),
              child: TextFormField(
                validator: (textField) {
                  if (addTaskProvider.textFieldIsEmpty(textField!)) {
                    return 'Please Enter Some Text';
                  }
                },
                decoration: const InputDecoration(
                    hintText: 'What are you going to do?',
                    border: OutlineInputBorder()),
                onChanged: (todo) {
                  addTaskProvider.setTextField(todo);
                  addTaskProvider.validateFormState();
                },
              ),
            ),
            TextButton.icon(
              onPressed: () {
                if (addTaskProvider.validateFormState()) {
                  homePageState.addTask(addTaskProvider.getTextField);
                  Navigator.of(context).pop();
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Add'),
              style: TextButton.styleFrom(
                primary: Colors.green[300],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AddTaskPageState with ChangeNotifier {
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
