import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:phonenumberauth/model/user_model.dart';

class FirebaseServices {
  
  final CollectionReference firebaseUsers =
      FirebaseFirestore.instance.collection('user');

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

  void deleteUser(String docId) {
    firebaseUsers.doc(docId).delete();
  }
}
