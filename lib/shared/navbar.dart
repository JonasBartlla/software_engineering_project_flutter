import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/pages/home/tasks/create_task_screen.dart';
import 'package:software_engineering_project_flutter/services/databaseService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';

class MyBottomNavigationBar extends StatefulWidget {
  MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  
  int _currentIndex = 0;

  //das hier muss in den Body bei Home
  // final List<Widget> _pages =  [
  //   CreateToDo(),
  // ];

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);
    final DatabaseService _database = DatabaseService(uid: user?.uid);
    return BottomNavigationBar(
      backgroundColor: AppColors.myCheckITDarkGrey,
      currentIndex: _currentIndex,
      onTap: (index){
        setState(() {
          _currentIndex = index;
        });
        if(_currentIndex == 1){
          _database.getAvailableListForUser().then((lists){
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateToDo(listCreatedFrom: null, availableLists: lists)));
          });
          _currentIndex = 0;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Listen',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'ToDo erstellen',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Kalender',
        ),
      ],
    );
  }
}