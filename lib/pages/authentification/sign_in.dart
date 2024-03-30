import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/services/authService.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';
import 'package:software_engineering_project_flutter/shared/loading.dart';
import 'package:software_engineering_project_flutter/shared/textfields.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key, this.toggleView});

  final Function? toggleView;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  // text field state

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    // if loading is true show loading screen, else shown sign in page
    return loading
        ? Loading()
        : Scaffold(
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
                          'Willkommen! ',
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
                          child: TextFormField(
                            cursorColor: AppColors.myCheckItGreen,
                            style:
                                const TextStyle(color: AppColors.myTextColor),
                            decoration: textInputDecoration.copyWith(
                                hintText: 'E-Mail'),
                            validator: (val) {
                              if (val!.isEmpty) {
                                // return null if valid
                                return "Bitte eine gültige E-Mail eingeben";
                              } else {
                                return null;
                              }
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

                        //Passwort eingabe
                        const Text(
                          'Passwort',
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
                          child: TextFormField(
                            cursorColor: AppColors.myCheckItGreen,
                            style:
                                const TextStyle(color: AppColors.myTextColor),
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Passwort'),
                            validator: (val) {
                              if (val!.length < 6 || val.isEmpty) {
                                return "Bitte ein Passwort mit mindestens 8 Zeichen angeben";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (val) {
                              password = val; // same for password
                            },
                            obscureText: true,
                          ),
                        ),

                        const SizedBox(height: 25),

                        //log in Button
                        TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              //Checks if all Validations are passed, falls überall null zurück geliefert wird wird true returnt => ist valid
                              setState(() {
                                loading = true;
                              });
                              dynamic result = await _auth
                                  .signInWithEmailAndPassword(email, password);
                              if (result == null) {
                                setState(() {
                                  error = 'E-Mail oder Passwort ist falsch';
                                  loading = false;
                                });
                              }
                            }
                          },
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
                          child: const Text(
                            'Log In',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),

                        const SizedBox(height: 25),

                        //Registrierung
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Du hast noch keinen Account?',
                                style: TextStyle(
                                  color: AppColors.myTextColor,
                                ),
                              ),
                              TextButton(
                                  style: ButtonStyle(
                                      overlayColor: MaterialStateProperty.all(
                                          AppColors.myCheckITDarkGrey)),
                                  onPressed: () {
                                    widget.toggleView!();
                                  },
                                  child: const Text(
                                    'Hier registrieren',
                                    style: TextStyle(
                                      color: AppColors.myCheckItGreen,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColors.myCheckItGreen
                                    ),
                                  ))
                            ]),
                        const SizedBox(height: 7),
                        //Passwort vergessen
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Passwort vergessen?',
                              style: TextStyle(color: AppColors.myTextColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text(
                          error,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14.0,
                          ),
                        ),
                        ElevatedButton(onPressed: () async{
                            dynamic user = await _auth.signInWithGooglea();
                        }, child: Text('Hi'))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
