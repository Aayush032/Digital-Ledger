import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class StorageServices{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> storeNewUser(data, context) async{
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return await _firestore.collection("users").doc(userId).set(data);
  }
  Future<String> storeNewBusiness(data) async{
    String res = "Some error occurred";
     final userId = FirebaseAuth.instance.currentUser!.uid;
     final businessId = Uuid().v4();
    try{
      await _firestore.collection("users").doc(userId).collection("business").doc(businessId).set(data);
      res = "success";
    }catch(e){
      res = e.toString();
    }
    return res;
  }
}