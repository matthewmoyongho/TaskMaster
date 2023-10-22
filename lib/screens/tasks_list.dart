import 'package:flutter/material.dart';
import 'package:todos_with_bloc/widgets/add_task_bottom_sheet.dart';
import 'package:todos_with_bloc/widgets/bottom_nav_bar.dart';

import './home_tabs/completed_tasks.dart';
import './home_tabs/favourite_tasks.dart';
import './home_tabs/pending_tasks.dart';
import '../widgets/app_drawer.dart';

class TasksList extends StatefulWidget {
  TasksList({Key? key}) : super(key: key);

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  List<Map<String, Widget>> tabs = [
    {'title': const Text('Pending Tasks'), 'body': PendingTab()},
    {'title': const Text('Completed Tasks'), 'body': CompletedTab()},
    {'title': const Text('Favourite Tasks'), 'body': FavouriteTab()},
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: tabs[currentIndex]['title'],
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  //isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  context: context,
                  builder: (context) => AddTaskBottomSheet());
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: tabs[currentIndex]['body'],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              //isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              context: context,
              builder: (ctx) => AddTaskBottomSheet());
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
