import 'package:flutter/material.dart';
import 'package:software_engineering_project_flutter/pages/authentification/reset_password.dart';
import 'package:software_engineering_project_flutter/services/authService.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';
import 'package:software_engineering_project_flutter/shared/loading.dart';
import 'package:software_engineering_project_flutter/shared/textfields.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';
import 'package:sign_in_button/sign_in_button.dart';

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
                          padding: const EdgeInsets.symmetric(horizontal: 50),
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
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: TextFormField(
                            cursorColor: AppColors.myCheckItGreen,
                            style:
                                const TextStyle(color: AppColors.myTextColor),
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Passwort'),
                            validator: (val) {
                              if (val!.length < 6 || val.isEmpty) {
                                return "Bitte ein Passwort mit mindestens 8 Zeichen eingeben";
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
                          child: Text(
                            'Einloggen',
                            style: standardTextDecoration.copyWith(fontWeight: FontWeight.bold)
                          ),
                        ),

                        const SizedBox(height: 40),

                         Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Zentriert die Elemente horizontal
                          children: [
                            const Expanded(
                              child: Divider(
                                color: AppColors.myTextInputColor,
                                thickness: 3.0,
                                indent: 50, // Abstand vom linken Bildschirmrand
                                endIndent:
                                    10, // Abstand vom rechten Bildschirmrand
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal:
                                      10.0), // Abstand zwischen Strich und Text
                              child: Text(
                                'ODER',
                                style: standardTextDecoration.copyWith(color: AppColors.myTextInputColor, fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                            ),
                            const Expanded(
                              child: Divider(
                                color: AppColors.myTextInputColor,
                                thickness: 3.0,
                                indent: 10, // Abstand vom linken Bildschirmrand
                                endIndent:
                                    50, // Abstand vom rechten Bildschirmrand
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15,),

                        //google log in Button
                        SignInButton(
                          Buttons.google,
                          onPressed: () async {
                            _auth.signInWithGoogleWeb();
                          },
                          text: "Einloggen mit Google",
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),

                        const SizedBox(height: 50),
                        //Registrierung
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               Text(
                                'Du hast noch keinen Account?',
                                 style: standardTextDecoration.copyWith(fontSize: 14),
                              ),
                              TextButton(
                                  style: ButtonStyle(
                                      overlayColor: MaterialStateProperty.all(
                                          AppColors.myCheckITDarkGrey)),
                                  onPressed: () {
                                    widget.toggleView!();
                                  },
                                  child:  Text(
                                    'Hier registrieren',
                                    style: standardTextDecoration.copyWith(fontSize: 14, color: AppColors.myCheckItGreen, fontWeight: FontWeight.bold, decoration: TextDecoration.underline, decorationColor: AppColors.myCheckItGreen),
                                  ))
                            ]),
                        const SizedBox(height: 7),
                        //Passwort vergessen
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextButton(
                              style: ButtonStyle(
                                      overlayColor: MaterialStateProperty.all(
                                          AppColors.myCheckITDarkGrey)),
                              onPressed: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ResetPasswordPage()));
                              },
                              child: Text(
                                'Passwort vergessen?',
                                style: standardTextDecoration.copyWith(fontSize: 14, color: AppColors.myCheckItGreen, fontWeight: FontWeight.bold, decoration: TextDecoration.underline, decorationColor: AppColors.myCheckItGreen),
                              ),
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
