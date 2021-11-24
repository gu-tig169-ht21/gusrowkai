import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class TaskTile extends StatelessWidget {
  TaskTile(this.task, this.taskIndex);

  dynamic task;
  int taskIndex;

  @override
  Widget build(BuildContext context) {
    var myStateProvider = Provider.of<MyState>(context, listen: false);

    return ListTile(
      title: Text.rich(TextSpan(
        text: task['title'],
        style: task['done']
            ? const TextStyle(decoration: TextDecoration.lineThrough)
            : null,
      )),
      leading: SizedBox(
        width: 50,
        height: 50,
        child: Consumer<MyState>(
          builder: (context, state, child) => Checkbox(
              value: task['done'],
              onChanged: (checkValue) {
                myStateProvider.changeCheckBoxValue(checkValue, taskIndex);

                if (state.turnary == false) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                }

                state.turnary = false;

                final snackBar = SnackBar(
                  backgroundColor: Colors.black87,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  elevation: 1,
                  width: MediaQuery.of(context).size.width / 1.1,
                  behavior: SnackBarBehavior.floating,
                  content: Row(
                    children: [
                      Icon(
                        checkValue == true
                            ? Icons.check_circle_outline_sharp
                            : Icons.remove_done_outlined,
                        color: checkValue == true
                            ? Colors.lightBlue
                            : Colors.blueGrey[100],
                      ),
                      SizedBox(width: 15),
                      Text(
                        checkValue == true
                            ? 'Task Set to Done!'
                            : 'Task Marked as Undone!',
                      )
                    ],
                  ),
                  action: SnackBarAction(
                    label: 'Dismiss',
                    onPressed: () {},
                  ),
                );

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }),
        ),
      ),
      trailing: Consumer<MyState>(
        builder: (context, state, child) => IconButton(
          icon: const Icon(
            Icons.delete,
            size: 26,
          ),
          onPressed: () {
            myStateProvider.deleteTask(taskIndex);

            if (state.turnary == false) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            }

            state.turnary = false;

            final snackBar = SnackBar(
              behavior: SnackBarBehavior.floating,
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              width: MediaQuery.of(context).size.width / 1.1,
              content: Row(
                children: [
                  Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  SizedBox(width: 15),
                  Text('Task Has Been Removed!')
                ],
              ),
              backgroundColor: (Colors.black87),
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () {},
              ),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
        ),
      ),
    );
  }
}
