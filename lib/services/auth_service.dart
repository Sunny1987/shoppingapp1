//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:scoped_model/scoped_model.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:testapp1/models/favoutites_model.dart';
//import 'package:testapp1/views/favouriteview.dart';
import '../models/user_model.dart';

class AuthService extends Model {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final prefs = SharedPreferences.getInstance();

  AppUser _user;

  AppUser _userFromFirebase(FirebaseUser user) {
    if (user != null) {
      AppUser appuser = AppUser(uid: user.uid);

      getUsersData(appuser);
      //getFavourites(appuser);
      return appuser;
    } else {
      return null;
    }
    //return user != null ? AppUser(uid: user.uid) : null;
    // return AppUser();
  }

  Stream<AppUser> get user {
    notifyListeners();
    print('_user: $_user ');
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
        'createdAt': FieldValue.serverTimestamp(),
      });
      // });

      return Future.value(true);
    } catch (e) {
      print(e.message);

      return Future.value(false);
    }
  }

  getUsersData(AppUser user) {
    Firestore.instance
        .collection('users')
        .where('id', isEqualTo: '${user.uid}')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((element) {
        //print(element.data['username']);
        user.username = element.data['username'];
      });
    });
  }

  Future<QuerySnapshot> getFavourites(AppUser user) async {
    return await Firestore.instance
        .collection('user_favourites')
        .where('id', isEqualTo: '${user.uid}')
        .getDocuments();
  }

  void firestoreAction(bool isFav, String docId, String uid, String name,
      String description, String price, String discount, String image) async {
    if (isFav) {
      await uploadUserFavourites(
          uid, name, description, price, discount, image);
    } else {
      await deleteUserFavourites(docId);
    }
  }

  void deleteUserFavourites(String docId) async {
    await Firestore.instance
        .collection('user_favourites')
        .document(docId)
        .delete();
  }

  void uploadUserFavourites(String uid, String name, String description,
      String price, String discount, String image) async {
    try {
      await Firestore.instance
          .collection('user_favourites')
          .document()
          .setData({
        'id': uid,
        'name': name,
        'description': description,
        'price': price,
        'discount': discount,
        'image': image,
        'createdAt': FieldValue.serverTimestamp()
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void uploadUserCart(String uid, String name, String description,
      String price, String discount,String quantity, String image) async {
    try {
      await Firestore.instance
          .collection('user_cart')
          .document()
          .setData({
        'id': uid,
        'name': name,
        'description': description,
        'price': price,
        'discount': discount,
        'quantity': quantity,
        //'docId': docId,
        'image': image,
        'createdAt': FieldValue.serverTimestamp()
      });
    } catch (e) {
      print(e.toString());
    }
  }

 Future<QuerySnapshot> getUserCart(AppUser user) async {
    return await Firestore.instance
        .collection('user_cart')
        .where('id', isEqualTo: '${user.uid}')
        .getDocuments();
  }

}
