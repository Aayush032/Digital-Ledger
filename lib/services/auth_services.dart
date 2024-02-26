import 'package:digital_ledger/services/storage_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> createUser(data, context) async {
    String res = "Some error occurred";
    try {
      await _auth.createUserWithEmailAndPassword(
          email: data["email"], password: data["password"]);
      res = "success";
      StorageServices().storeNewUser(data, context);
    }
    on FirebaseAuthException catch(e){
      if(e.code == "email-already-in-use"){
        res = "Email already in use";
      }
    }
     catch (e) {
      res = e.toString();
    }
    return res;
  }
  Future<String> loginUser(data, context) async{
    String res = "some error occrred";
    try{
      await _auth.signInWithEmailAndPassword(email: data["email"], password: data["password"]);
      res = "success";
    }
    on FirebaseAuthException catch(e){
      if(e.code == "invalid-credential"){
        res = "Wrong credential";
      }
    }
    catch(e){
      res = e.toString();
    }
    return res;
  }
}
