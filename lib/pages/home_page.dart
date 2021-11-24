import 'package:flutter/material.dart';
import '../components/task_tile.dart';
import 'package:provider/provider.dart';
import '../main.dart';

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
          actions: [
            PopupMenuButton(
              onSelected: (filterValue) {
                Provider.of<MyState>(context, listen: false)
                    .setFilterOption(filterValue);
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  child: Text('All'),
                  value: 'all',
                ),
                const PopupMenuItem(
                  child: Text('Done'),
                  value: 'done',
                ),
                const PopupMenuItem(child: Text('Undone'), value: 'undone')
              ],
            ),
          ],
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
        body: SnackBarPage());
  }
}

class SnackBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyState>(
        builder: (context, state, child) => state.loadingPhase == true
            ? loadingWidget(context)
            : state.renderTaskList.isEmpty
                ? Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (state.filterValue == 'done') ...[
                            const Text('No Done Tasks')
                          ] else if (state.filterValue == 'undone') ...[
                            const Text('No Undone Tasks')
                          ] else ...[
                            const Text('No Added Tasks')
                          ]
                        ]),
                  )
                : Container(
                    child: ListView.separated(
                      itemCount: state.renderTaskList.length,
                      itemBuilder: (context, index) {
                        var task = state.renderTaskList[index];
                        return TaskTile(task, index);
                      },
                      separatorBuilder: (context, index) => const Divider(),
                    ),
                  ));
  }
}
