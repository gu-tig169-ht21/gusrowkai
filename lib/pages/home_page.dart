import 'package:flutter/material.dart';
import '../components/tasklist.dart';
import 'package:provider/provider.dart';
import '../components/task.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('home page built');
    var homePageProvider = Provider.of<HomePageState>(context);

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
        body: homePageProvider.getTasks.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [Text('No Added Tasks')],
                ),
              )
            : TaskList(
                homePageProvider.getTasks,
              ));
  }
}

class HomePageState with ChangeNotifier {
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
}
