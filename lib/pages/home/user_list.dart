import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering_project_flutter/models/task.dart';


class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    final List<Task>? users = Provider.of<List<Task>?>(context);
    if (users != null){
      users.forEach((user) { 
        print(user.name);
        print(user.age);
        print(user.hobby);
      });
    }
    return Container();
  }
}