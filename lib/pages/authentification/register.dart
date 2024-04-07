import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:software_engineering_project_flutter/services/authService.dart';
import 'package:software_engineering_project_flutter/shared/styles_and_decorations.dart';
import 'package:software_engineering_project_flutter/shared/loading.dart';
import 'package:software_engineering_project_flutter/shared/colors.dart';
import 'package:software_engineering_project_flutter/shared/validations.dart';

class Register extends StatefulWidget {
  const Register({super.key, this.toggleView});

  final Function? toggleView;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  // text field state

  String displayName = '';
  String email = '';
  String password = '';
  String password2 = '';
  String error = '';

  @override
  void setState(VoidCallback fn){
    if(mounted){
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      children: [
                        const SizedBox(height: 10),
                        //logo
                        const Text(
                          'CheckIT',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: AppColors.myCheckItGreen,
                              fontFamily: 'Comfortaa',
                              fontSize: 70,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
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
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),

                        const SizedBox(height: 60),

                        //willkommen
                        const Text(
                          'Registrieren! ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.myTextColor,
                              fontFamily: 'Comfortaa',
                              fontSize: 40,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),

                        const SizedBox(height: 70),

                        //Anzeigename
                        const Text(
                          'Anzeigename',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: AppColors.myTextColor,
                              fontFamily: 'Comfortaa',
                              fontSize: 16,
                              letterSpacing:
                                  1 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                        const SizedBox(height: 2),

                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: TextFormField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(20)
                            ],
                            cursorColor: AppColors.myCheckItGreen,
                            style:
                                const TextStyle(color: AppColors.myTextColor),
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Anzeigename'),
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Bitte gib ein Anzeigename ein";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (val) {
                              setState(() {
                                // when the value inside the eMail field changes the value of the variable wil be changed
                                displayName = val;
                              });
                            },
                          ),
                        ),

                        const SizedBox(height: 25),

                        //Email Adresse
                        const Text(
                          'E-Mail Adresse',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: AppColors.myTextColor,
                              fontFamily: 'Comfortaa',
                              fontSize: 16,
                              letterSpacing:
                                  1 /*percentages not used in flutter. defaulting to zero*/,
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
                              letterSpacing:
                                  1 /*percentages not used in flutter. defaulting to zero*/,
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
                              if (val == null || val.isEmpty) {
                                return "Bitte gib ein Passwort ein";
                              } else if (validatePasswordPolicy(val) == false) {
                                return "Das Passwort entspricht nicht den Passwortrichtlinien:\n- zwischen 8 und 20 Zeichen\n- mindestens ein Groß- und Kleinbuchstabe\n- mindestens eine Zahl\n- mindestens ein Sonderzeichen (!@#\$&*~.)";
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

                        //Passwort erneut eingeben
                        const Text(
                          'Passwort wiederholen',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: AppColors.myTextColor,
                              fontFamily: 'Comfortaa',
                              fontSize: 16,
                              letterSpacing:
                                  1 /*percentages not used in flutter. defaulting to zero*/,
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
                              return validateRepeatPassword(
                                  val as String, password);
                            },
                            onChanged: (val) {
                              password2 = val; // same for password
                            },
                            obscureText: true,
                          ),
                        ),

                        const SizedBox(height: 25),

                        //Registrierung Button
                        TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              //Checks if all Validations are passed, falls überall null zurück geliefert wird wird true returnt => ist valid
                              setState(() {
                                loading = true;
                              });
                              dynamic result =
                                  await _auth.registerWithEmailAndPassword(
                                      email, password, displayName);
                              if (result == '[firebase_auth/email-already-in-use] The email address is already in use by another account.') { // FirebaseAuthUserCollisionException
                                setState(() {
                                  error = 'Zu dieser E-Mail existiert bereits ein Account. Bitte verwende diesen.';
                                  loading = false;
                                });
                              }else { //FirebaseAuthInvalidCredentialsException
                                setState(() {
                                  error = 'Während der Anmeldung ist ein Fehler aufgetreten. Bitte wende dich an den Support.'; 
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
                            'Registrieren',
                            style: standardTextDecoration.copyWith(fontWeight: FontWeight.bold)
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(error,
                        style: const TextStyle(color: AppColors.myDeleteColor),
                        ),

                        const SizedBox(height: 5,),
                        //google log in Button
                        SignInButton(
                          Buttons.google,
                          onPressed: () async {
                            _auth.signInWithGoogleWeb();
                          },
                          text: "Registrieren mit Google",
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        //hier einloggen
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Du hast bereits einen Account?',
                                style: standardTextDecoration.copyWith(fontSize: 14),
                              ),
                              TextButton(
                                  style: ButtonStyle(
                                      overlayColor: MaterialStateProperty.all(
                                          AppColors.myCheckITDarkGrey)),
                                  onPressed: () {
                                    widget.toggleView!();
                                  },
                                  child: Text(
                                    'Hier einloggen',
                                    style: standardTextDecoration.copyWith(fontSize: 14, color: AppColors.myCheckItGreen, fontWeight: FontWeight.bold, decoration: TextDecoration.underline, decorationColor: AppColors.myCheckItGreen),
                                  ))
                            ]),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
