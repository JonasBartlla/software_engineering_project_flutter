import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:software_engineering_project_flutter/services/database_service.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';
import 'package:software_engineering_project_flutter/shared/validations.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {


  String? email;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseService _databaseService = DatabaseService();
  final _formKey = GlobalKey<FormState>();

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.myBackgroundColor,
      //         size: 35),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      //   backgroundColor: const Color.fromRGBO(101, 167, 101, 1),
      //   title: Text(
      //     'Passwort zurücksetzen',
      //     style: standardAppBarTextDecoration.copyWith(fontSize: 25 ),
      //   ),
      // ),
            backgroundColor: AppColors.myBackgroundColor,
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 10),
                        //logo
                        const Text(
                          'CheckIT',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: AppColors.myCheckItGreen,
                              fontFamily: 'Comfortaa',
                              fontSize: 70,
                              letterSpacing: 0,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                        const SizedBox(height: 1),

                        const Text(
                          'ORGANIZE YOUR DAY',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: AppColors.myCheckItGreen,
                              fontFamily: 'Comfortaa',
                              fontSize: 16,
                              letterSpacing: 0,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),

                        const SizedBox(height: 60),

                        //willkommen
                        const Text(
                          'Passwort\nzurücksetzen',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.myTextColor,
                              fontFamily: 'Comfortaa',
                              fontSize: 40,
                              letterSpacing: 0,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),

                        const SizedBox(height: 70),

                        //Email Adresse
                        const Text(
                          'E-Mail Adresse',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: AppColors.myTextColor,
                              fontFamily: 'Comfortaa',
                              fontSize: 16,
                              letterSpacing: 1,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                        const SizedBox(height: 2),

                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: TextFormField(
                            cursorColor: AppColors.myCheckItGreen,
                            style:
                                const TextStyle(color: AppColors.myTextColor),
                            decoration: textInputDecoration.copyWith(
                                hintText: 'E-Mail'),
                            validator: (val) {
                              return validateEmail(val);
                            },
                            onChanged: (val) {
                              setState(() {
                                // when the value inside the eMail field changes the value of the variable wil be changed
                                email = val;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 25),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: TextButton.icon(
                            style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              const EdgeInsets.all(25),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.myCheckItGreen,
                            ),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                            onPressed: () async {
                              //Standardmäßiges Errorhandling mit sendPasswordResetEmail funktioniert nicht, deshalb eigene implemenation mit Datenbankabfrage
                              
                              QuerySnapshot users = await _databaseService.userCollection.get();
                              List<String> emailList = users.docs.map((e) => e.get('email') as String).toList();

                              if (_formKey.currentState!.validate()) {
                                showDialog(
                                context: context,
                                barrierDismissible: false, 
                                builder: (context) => const Center(child: SpinKitChasingDots(
                                  color: AppColors.myCheckItGreen,
                                ),));

                                  if(emailList.contains(email)){
                                  await _auth.sendPasswordResetEmail(email: email!.trim());

                                  final snackBar = SnackBar(
                                    backgroundColor: AppColors.myCheckItGreen,
                                    content: Text('Rücksetzungs-Email an $email gesendet'),
                                    duration: const Duration(seconds: 2),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  Navigator.of(context).popUntil((route) => route.isFirst);
                                  } else{
                                    const snackBar = SnackBar(
                                    backgroundColor: AppColors.myDeleteColor,
                                    content: Text('Kein Account zu dieser Email gefunden.'),
                                    duration: const Duration(seconds: 2),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  Navigator.pop(context);
                                  }
                                  // final snackBar = SnackBar(
                                  //   backgroundColor: AppColors.myDeleteColor,
                                  //   content: Text(e.message),
                                  //   duration: const Duration(seconds: 2),
                                  // );
                                }
                              }, 
                            icon: const Icon(Icons.mail, color: AppColors.myTextColor,), 
                            label:  Text('Passwort zurücksetzen', style: standardTextDecoration.copyWith(fontWeight: FontWeight.bold),)),
                        ),
                        const SizedBox(height: 15),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               Text(
                                'Doch nicht vergessen?',
                                style: standardTextDecoration.copyWith(fontSize: 14),
                              ),
                              TextButton(
                                  style: ButtonStyle(
                                      overlayColor: MaterialStateProperty.all(
                                          AppColors.myCheckITDarkGrey)),
                                  onPressed: () {
                                    Navigator.of(context).popUntil((route) => route.isFirst);
                                  },
                                  child: Text(
                                    'Hier einloggen',
                                    style: standardTextDecoration.copyWith(fontSize: 14, color: AppColors.myCheckItGreen, fontWeight: FontWeight.bold, decoration: TextDecoration.underline, decorationColor: AppColors.myCheckItGreen),
                                  // TextStyle(
                                  //       color: AppColors.myCheckItGreen,
                                  //       fontWeight: FontWeight.bold,
                                  //       decoration: TextDecoration.underline,
                                  //       decorationColor:
                                  //           AppColors.myCheckItGreen),
                                  // 
                                  ))
                            ]),
                      ]
                    )
                  )
                )
              )
            )
    );
  }
}