import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phonenumberauth/services/google_service.dart';

class GoogleAuthProvider extends ChangeNotifier {
  GoogleService googleServiceAuth = GoogleService();
  
  //GOOGLE SIGN IN
 Future<UserCredential> signInWithGoogle() async {
  // Assuming googleServiceAuth.signInWithGoogle() returns a Future<UserCredential>
  UserCredential userCredential = await googleServiceAuth.signInWithGoogle();
  return userCredential;
}

//  Future<UserCredential> signInWithGoogle() async {
//     return googleServiceAuth.signInWithGoogle();
//   }

}
