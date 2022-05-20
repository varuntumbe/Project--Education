import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mapp/core/models/user.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      Firestore.instance.collection('users');

  Future createUser(User newUser) async {
    try {
      await _usersCollectionReference
          .document(newUser.id)
          .setData(newUser.toJson());
    } catch (e) {
      return e.message;
    }
    return true;
  }

  Future getUser(String uid) async {
    try {
      var userData = await _usersCollectionReference.document(uid).get();
      return User.fromData(userData.data);
    } catch (e) {}
  }
}
