import 'package:software_engineering_project_flutter/shared/validate_Domains.dart';

bool validateEmail(String value){
  
  value = value.substring(start);
  if(validateDomains.contains(value)){
    return true;
  }
  return false;
}

bool validatePasswordPolicy(String value){
        if(value.length < 8 || value.length>20){
          return false; 
        }
        String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~.]).{8,}$';
        RegExp regExp = RegExp(pattern);
        return regExp.hasMatch(value);
  }