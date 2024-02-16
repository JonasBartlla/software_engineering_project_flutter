import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/pages/home/tasks/create_task_screen.dart';


class MyBottomNavigationBar extends StatefulWidget {
  MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  
  int _currentIndex = 0;

  //das hier muss in den Body bei Home
  final List<Widget> _pages =  [
    CreateToDo(),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color.fromRGBO(101, 167, 101, 1),
      currentIndex: _currentIndex,
      onTap: (index){
        setState(() {
          _currentIndex = index;
        });
        if(_currentIndex == 1){
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateToDo()));
          _currentIndex = 0;
        }
      },
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