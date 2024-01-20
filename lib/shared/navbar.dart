import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/pages/toDo/create_todo.dart';
import 'package:software_engineering_project_flutter/pages/toDo/home.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int index = 0;
  final screens = [
    Home(),
    CreateToDo(),
  ];

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
        backgroundColor: const Color.fromRGBO(101, 167, 101, 1),
        selectedIndex: index,
        onDestinationSelected: (index) =>
            setState(() => this.index = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.list_rounded), 
            label: 'Listenansicht'),
          NavigationDestination(
            icon: Icon(Icons.add), 
            label: 'ToDo Erstellen'),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined), 
            label: 'Kalender'
            ),
        ]
      );
  }
}