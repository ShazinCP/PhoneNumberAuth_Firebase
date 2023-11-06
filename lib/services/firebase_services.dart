import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:phonenumberauth/model/user_model.dart';

class FirebaseServices {
  
  final CollectionReference firebaseUsers =
      FirebaseFirestore.instance.collection('users');

  Future<List<UserModel>> fetchUser() async {
    final snapshot = await firebaseUsers.get();
    return snapshot.docs.map((doc) {
      return UserModel.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  void updateUser(UserModel user) {
    final data = user.toMap();
    firebaseUsers.doc(user.uid).update(data);
  }


    //google sign in
  signInWithGoogle()async{
     // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
