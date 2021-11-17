import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/add_task_page.dart';
import 'package:provider/provider.dart';
import 'components/task.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomePageState(),
      child: ChangeNotifierProvider(
        create: (context) => AddTaskPageState(),
        child: ChangeNotifierProvider(
          create: (context) => TaskState(),
          //consider multiprovider
          child: MaterialApp(
            routes: {
              '/': (context) => HomePage(),
              '/addtask': (context) => AddTaskPage()
            },
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }
}
