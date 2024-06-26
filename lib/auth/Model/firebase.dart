
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethod {
  Future addUser(String userId, Map<String, dynamic> userInfoMap){
    return FirebaseFirestore.instance.collection("Merchant").doc(userId).set(userInfoMap);
  }

}