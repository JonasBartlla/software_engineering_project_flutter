import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/pages/home/tasks/create_task_screen.dart';


class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color.fromRGBO(101, 167, 101, 1),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Liste',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Hinzufügen',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Kalender',
        ),
      ],
    );
  }
}