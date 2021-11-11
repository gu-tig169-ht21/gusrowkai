import 'package:flutter/material.dart';
import 'task.dart';

void main() {
  runApp(MaterialApp(
    home: Tasks(),
    debugShowCheckedModeBanner: false,
  ));
}

class Tasks extends StatelessWidget {
  List<String> tasks = List.generate(30, (index) => 'ListItem #$index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TIG169 TODO',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[500],
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[500],
        onPressed: () {},
        child: Icon(
          Icons.add,
          size: 50,
          color: Colors.white,
        ),
      ),
      body: tasks.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('No Added Tasks')],
              ),
            )
          : ListView.separated(
              itemBuilder: (context, index) {
                final item = tasks[index];

                return Task(item);
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: tasks.length),
    );
  }
}
