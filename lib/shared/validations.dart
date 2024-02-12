import 'package:software_engineering_project_flutter/shared/validate_Domains.dart';
import 'package:list_ext/list_ext.dart';

String? validateEmail(String? value){
  if(value == null || value.isEmpty){
    return 'Bitte geben Sie eine E-Mail-Addresse ein';
  } else if (1 != value.split('').countWhere((element) => element == "@")){
    return "Nur E-Mails mit genau eine @-Zeichen sind gültig";
  } else {
    value = value.substring(value.indexOf("@")+1);
    print(value);
    if (validateDomains.contains(value)){
      return null;
    }else{
      return "Ihre E-Mail-Addresse enthält keine gültige Domain";
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
                          return "Die beiden Passwörter stimmen nicht über ein";
                        }
                        else{
                          return null;
                        }
}