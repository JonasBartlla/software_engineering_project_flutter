import 'package:software_engineering_project_flutter/shared/validate_Domains.dart';
import 'package:list_ext/list_ext.dart';

String? validateEmail(String? value){
  if(value == null || value.isEmpty){
    return 'Bitte gib eine E-Mail Adresse ein';
  } else if (1 != value.split('').countWhere((element) => element == "@")){
    return "Nur E-Mails mit genau einem @-Zeichen sind gültig";
  } else {
    value = value.substring(value.indexOf("@")+1);
    if (validateDomains.contains(value)){
      return null;
    }else{
      return "E-Mail Adresse enthält keine gültige Domain";
    }
  }
}

bool validatePasswordPolicy(String value){
        if(value.length < 8 || value.length>20){
          return false; 
        }
        String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~.]).{8,}$';
        RegExp regExp = RegExp(pattern);
        return regExp.hasMatch(value);
  }

String? validateRepeatPassword(String value, String password){
                          if (value != password){
                          return "Die beiden Passwörter stimmen nicht überein";
                        }
                        else{
                          return null;
                        }
}