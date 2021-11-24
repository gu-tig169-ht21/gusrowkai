import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';

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
      body: Form(
        key: myStateProvider.getFormKey,
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(30),
              child: TextFormField(
                validator: (textField) {
                  if (myStateProvider.textFieldIsEmpty(textField!)) {
                    return 'Please Enter Some Text';
                  }
                },
                decoration: const InputDecoration(
                    hintText: 'What are you going to do?',
                    border: OutlineInputBorder()),
                onChanged: (textInput) {
                  myStateProvider.setTextField(textInput);
                  myStateProvider.validateFormState();
                },
              ),
            ),
            TextButton.icon(
              onPressed: () {
                if (myStateProvider.validateFormState()) {
                  myStateProvider.addTask(myStateProvider.getTextField);

                  Navigator.of(context).pop();

                  final snackBar = SnackBar(
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    elevation: 1,
                    width: MediaQuery.of(context).size.width / 1.1,
                    content: Row(
                      children: [
                        Icon(
                          Icons.add_task_rounded,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text('Successfully added a task')
                      ],
                    ),
                    backgroundColor: (Colors.black87),
                    action: SnackBarAction(
                      label: 'Dismiss',
                      onPressed: () {},
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
