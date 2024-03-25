import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering_project_flutter/services/databaseService.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';

class CreateListPage extends StatefulWidget {
  const CreateListPage({super.key});

  @override
  State<CreateListPage> createState() => _CreateListPageState();
}

class _CreateListPageState extends State<CreateListPage> {
  final _formKey = GlobalKey<FormState>();

  //Felder einer Liste
  String title = '';
  IconData icon = Icons.format_list_bulleted;

  //Liste für die Icons
  List<IconData> choosableIcons = [
    Icons.format_list_bulleted,
    Icons.house,
    Icons.calendar_month_rounded
  ];

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);
    final DatabaseService _database = DatabaseService(uid: user?.uid);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(40, 40, 40, 1),
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: const Color.fromRGBO(101, 167, 101, 1),
        title:Text(
            'Liste erstellen',
            style: standardAppBarTextDecoration,
          ),
        ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    width: 360,
                    height: 265,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      color: AppColors.myCheckITDarkGrey,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            const SizedBox(
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 40.0,
                              ),
                            ),
                            const SizedBox(width: 5),
                            PhysicalModel(
                              color: AppColors.myCheckITDarkGrey,
                              //elevation: 8,
                              shadowColor: AppColors.myShadowColor,
                              child: SizedBox(
                                width: 303,
                                //Bezeichnung eingeben
                                child: TextFormField(
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(20)
                                  ],
                                  style: const TextStyle(
                                      color: AppColors.myTextColor),
                                  initialValue: "",
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Bitte eine Bezeichnung eingeben';
                                    } else if (value.length > 20) {
                                      return 'Bezeichnung darf nicht länger als 20 Zeichen sein';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: textInputDecorationbez.copyWith(
                                      hintText: 'Bezeichnung'),
                                  onChanged: (value) => setState(() {
                                    title = value;
                                  }),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 45),
                        Row(
                          children: <Widget>[
                            const SizedBox(width: 8),
                            const Text(
                              'Icon:',
                              style: TextStyle(
                                  color: AppColors.myTextColor,
                                  fontFamily: 'Comfortaa',
                                  fontSize: 18,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 288,
                              child: DropdownButtonFormField<IconData>(
                                  decoration: textInputDecoration.copyWith(
                                      hintText: 'Icon'),
                                  items: choosableIcons.map((icon) {
                                    return DropdownMenuItem(
                                      value: icon,
                                      child: Icon(icon),
                                    );
                                  }).toList(),
                                  onChanged: (value) => setState(() {
                                        icon = value!;
                                      })),
                            ),
                          ],
                        ),
                        const SizedBox(height: 45),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              //Abbrechen Button
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Abbrechen',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            SizedBox(
                              //Erstellen Button
                              child: ElevatedButton(
                                style: buttonStyleDecorationcolorchange,
                                child: const Text('Erstellen'),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _database.addList(title, icon);
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Vorschau:',
                  style: TextStyle(
                      color: AppColors.myTextInputColor,
                      fontFamily: 'Comfortaa',
                      fontSize: 20,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                      height: 1),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 300,
                  width: 350,
                  child: Card(
                    color: AppColors.myCheckITDarkGrey,
                      child: Padding(
                        padding: const EdgeInsets.all(100),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(icon, color: AppColors.myCheckItGreen,),
                            const SizedBox(height: 20),
                            Text(title, style: standardHeadlineDecoration,)
                          ],
                        ),
                      ),                  
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
