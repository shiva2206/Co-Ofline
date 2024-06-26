import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co_ofline/auth/Model/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  getCurrentUser() async {
    return await auth.currentUser;
  }

  signInWithGoogle(BuildContext context) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleSignInAuthentication =
    await googleSignInAccount?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication?.idToken,
        accessToken: googleSignInAuthentication?.accessToken);
    UserCredential result = await firebaseAuth.signInWithCredential(credential);


    User? userDetails = result.user;

    

    if (result != null) {
      Map<String, dynamic> userInfoMap = {
        "email": userDetails!.email,
        "name": userDetails.displayName,
        "imgUrl": userDetails.photoURL,
        "id": userDetails.uid,

    
      };

      bool doesExists = await checkDocumentExists(userDetails.uid);
      if (!doesExists){
           await DatabaseMethod()
              .addUser(userDetails.uid, userInfoMap)
              .then((value) => {});
      }

     
    }
  }

   Future<bool> checkDocumentExists(String docId) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    DocumentReference docRef = _firestore.collection('Merchant').doc(docId);

    try {
      DocumentSnapshot docSnap = await docRef.get();

      return docSnap.exists;
    } catch (e) {
      print("Error getting document: $e");
    }
    return false;
  }
}
