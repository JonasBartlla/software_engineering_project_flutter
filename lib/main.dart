import 'dart:developer';
import 'dart:html';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/firebase_options.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MaterialApp(
  home: Home(),

  ));
}

  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

class Home extends StatelessWidget {
  const Home({super.key});



  // @override
  // void initState() {
  //   // Connect SideMenuController and PageController together
  //   sideMenu.addListener((index) {
  //     pageController.jumpToPage(index);
  //   });
  //   super.initState();
  // }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('CheckIT'),
          centerTitle: true,
          backgroundColor: Colors.deepOrange[500],
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SideMenu(
              // Page controller to manage a PageView
              controller: sideMenu,
              // Will shows on top of all items, it can be a logo or a Title text
              title: Image.asset('assets/todo.png'),
              // Will show on bottom of SideMenu when displayMode was SideMenuDisplayMode.open
              footer: const Text('demo'),
              // Notify when display mode changed
              onDisplayModeChanged: (mode) {
                print(mode);
              },
              // List of SideMenuItem to show them on SideMenu
              items: items,
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                children: [
                  Container(
                    child: const Center(
                      child: Text('Dashboard'),
                    ),
                  ),
                  Container(
                    child: const Center(
                      child: Text('Settings'),
                    ),
                  ),
                ],
              ),
            ),
            const Text('Welcome to the homepage',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
                fontFamily: 'RubikBubbles',
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                log('Yes sir');
              },
              icon: const Icon(Icons.plus_one),
              label: const Text('Add a new list'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.amber;
                    }else if (states.contains(MaterialState.hovered)){
                      return Colors.cyan;
                    }
                    return null; // Use the component's default.
                  },
                ),
              ),
            ),
            const Image(
            image: AssetImage('assets/todo.jpg'),
            fit: BoxFit.fill,
            ),
          ],
        ),
        
        
        //Center(
          // child: Text('Welcome to the homepage',
          //   style: TextStyle(
          //     fontSize: 20.0,
          //     fontWeight: FontWeight.bold,
          //     color: Colors.deepOrange,
          //     fontFamily: 'RubikBubbles',
          //   ),
          // child: Image(
          //   image: AssetImage('assets/todo.jpg'),
          //   fit: BoxFit.fill,
          // ),
          // child: ElevatedButton.icon(
        //     onPressed: () {
        //       log('Yes sir');
        //     },
        //     icon: const Icon(Icons.plus_one),
        //     label: const Text('Add a new list'),
        //     style: ButtonStyle(
        //       backgroundColor: MaterialStateProperty.resolveWith<Color?>(
        //         (Set<MaterialState> states) {
        //           if (states.contains(MaterialState.pressed)) {
        //             return Colors.amber;
        //           }else if (states.contains(MaterialState.hovered)){
        //             return Colors.cyan;
        //           }
        //           return null; // Use the component's default.
        //         },
        //       ),
        //     ),
        //   ),
        // ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Text('+'),
          backgroundColor: Colors.deepOrange[500],
      ),
    );
  }
}

List<SideMenuItem> items = [
  SideMenuItem(
    title: 'Dashboard',
    onTap:(index, sideMenuController) {
    },
    icon: const Icon(Icons.home),
    badgeContent: const Text(
      '3',
      style: const TextStyle(color: Colors.white),
    ),
  ),
  SideMenuItem(
    title: 'Settings',
    onTap: (index, sideMenuController) {
    },
    icon: const Icon(Icons.settings),
  ),
  SideMenuItem(
    title: 'Exit',
    onTap: (index, sideMenuController) {},
    icon: const Icon(Icons.exit_to_app),
  ),
];

