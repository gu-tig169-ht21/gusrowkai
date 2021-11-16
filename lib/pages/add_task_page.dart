import 'package:flutter/material.dart';
import 'package:my_first_app/pages/home_page.dart';
import 'home_page.dart';
import 'package:provider/provider.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  String textField = "";
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var homePageProvider = Provider.of<HomePageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
        centerTitle: true,
        backgroundColor: Colors.green[300],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(30),
              child: TextFormField(
                validator: (textField) {
                  if (textField == null || textField.isEmpty) {
                    return 'Please Enter Some Text';
                  }
                },
                decoration: const InputDecoration(
                    hintText: 'What are you going to do?',
                    border: OutlineInputBorder()),
                onChanged: (todo) {
                  setState(() => textField = todo);
                  _formKey.currentState!.validate();
                },
              ),
            ),
            TextButton.icon(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  homePageProvider.addTask(textField);
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
