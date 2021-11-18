import 'package:flutter/material.dart';
import 'package:my_first_app/pages/home_page.dart';
import 'home_page.dart';
import 'package:provider/provider.dart';
import '../pages/home_page.dart';

class AddTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var myStateProvider = Provider.of<MyState>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
        centerTitle: true,
        backgroundColor: Colors.green[300],
      ),
      body: Consumer<MyState>(
        builder: (context, value, child) => Form(
          key: value.getFormKey,
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(30),
                child: TextFormField(
                  validator: (textField) {
                    if (value.textFieldIsEmpty(textField!)) {
                      return 'Please Enter Some Text';
                    }
                  },
                  decoration: const InputDecoration(
                      hintText: 'What are you going to do?',
                      border: OutlineInputBorder()),
                  onChanged: (todo) {
                    myStateProvider.setTextField(todo);
                    value.validateFormState();
                  },
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  if (value.validateFormState()) {
                    myStateProvider.addTask(value.getTextField);
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
      ),
    );
  }
}
