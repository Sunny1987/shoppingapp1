import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/user_model.dart';

class AuthService extends Model {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppUser _userFromFirebase(FirebaseUser user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  Stream<AppUser> get user {
    notifyListeners();
    return _auth.onAuthStateChanged.map((user) => _userFromFirebase(user));
  }

  Stream<QuerySnapshot> fetchUserName() {
    Stream<QuerySnapshot> snapshot =
        Firestore.instance.collection('users').snapshots();
    notifyListeners();

    return snapshot;
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future mySignUp(String email, String password, String username) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print('result from authservice: $result');
      FirebaseUser user = result.user;
      uploadUsername(user.uid, username);
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      Future.value(null);
    }
  }

  Future mySignIn(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print('result from authservice: $result');
      FirebaseUser user = result.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      Future.value(null);
    }
  }

  Future<bool> uploadUsername(String uid, String username) async {
    try {
      await Firestore.instance.collection('users').document().setData({
        'id': uid,
        'username': username,
        'createdAt': FieldValue.serverTimestamp()
      });
      // });

      return Future.value(true);
    } catch (e) {
      print(e.message);

      return Future.value(false);
    }
  }


}
