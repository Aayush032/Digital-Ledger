class Validator{
  String? usernameValidator(value){
    if(value!.isEmpty){
      return "Please enter a username";
    }
    else{
      return null;
    }
  }

  String? emailValidator(value){
    if(value!.isEmpty){
      return "Please enter an email";
    }
    RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if(!emailRegex.hasMatch(value)){
      return "Please enter a valid email";
    }
    else{
      return null;
    }
  }

  String? passwordValidator(value){
    if(value!.isEmpty){
      return "Please enter a password";
    }
    if(value.length <= 8){
      return "Password must be longer than 8 characters";
    }
    else{
      return null;
    }
  }
}