import 'package:connect/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum Status {
  uninitialized,
  authenticated,
  authenticating,
  unauthenticated,
  registering
}

class AuthProvider with ChangeNotifier {
  late FirebaseAuth _auth;
  Status _status = Status.uninitialized;

  Status get status => _status;

  Stream<UserModel> get user => _auth.authStateChanges().map(_fromFirebaseUser);

  AuthProvider() {
    _auth = FirebaseAuth.instance;

    _auth.authStateChanges().listen(onAuthStateChanged);
  }

  UserModel _fromFirebaseUser(User? user) {
    if (user == null) {
      return UserModel(uid: 'null', displayName: 'Null');
    }
    return UserModel(
        uid: user.uid,
        displayName: user.displayName,
        email: user.email,
        photoUrl: user.photoURL);
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      _status = Status.authenticating;
      notifyListeners();
      print('signing in');
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      print('signed in');
      return true;
    } catch (e) {
      print('sign in failed');
      notifyListeners();
      _status = Status.unauthenticated;
      return false;
    }
  }

  Future<void> onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser != null) {
      _fromFirebaseUser(firebaseUser);
      _status = Status.authenticated;
    } else {
      _status = Status.unauthenticated;
    }
    notifyListeners();
  }

  Future signOut() async {
    _auth.signOut();
    _status = Status.unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }
}
