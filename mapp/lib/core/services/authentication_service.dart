import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:mapp/core/models/user.dart';
import 'package:mapp/core/services/firestoreDB_service.dart';
import 'package:mapp/locator.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = locator<FirestoreService>();

  User _currentUser;

  User get currentUser => _currentUser;

  Future loginWithEmain(
      {@required String email, @required String password}) async {
    try {
      var authUser = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      await _populateCurrentUser(authUser.user);

      return authUser.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future signUpWithEmail(
      {@required name,
      @required String email,
      @required String password}) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      /* Here we will call service from Firestore and User object*/
      if (authResult.user != null) {
        await _firestoreService.createUser(
          User(fullName: name, email: email, id: authResult.user.uid),
        );
      }

      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future<bool> isUserLoggedIn() async {
    var authUser = await _firebaseAuth.currentUser();
    await _populateCurrentUser(authUser);
    return authUser != null;
  }

  Future _populateCurrentUser(FirebaseUser user) async {
    if (user != null) {
      _currentUser = await _firestoreService.getUser(user.uid);
      print('current User');
      print(_currentUser.email);
    }
  }
}
