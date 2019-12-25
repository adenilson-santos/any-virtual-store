import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';

class UserModel extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map();

  bool isLoading = false;

  static UserModel of(BuildContext context) =>
         ScopedModel.of<UserModel>(context);

  @override
  void addListener(listener) {
    super.addListener(listener);

    _loadUserdata();
  }

  void signUp(
    {
      @required Map<String, dynamic> userData, 
      @required String pass, 
      @required VoidCallback onSuccess, 
      @required VoidCallback onFail
    }
  ) {
    isLoading = true;
    notifyListeners();

    _auth.createUserWithEmailAndPassword(
      email: userData['email'],
      password: pass
    ).then((authResult) async {
      firebaseUser = authResult.user;

      await _saveUserData(userData);

      onSuccess();
    }).catchError((err) {
      onFail();
    });

    isLoading = false;
    notifyListeners();
  }

  void signIn(
    {
      @required String email,
      @required String pass,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail
    }
  ) async {
    isLoading = true;
    notifyListeners();

    _auth.signInWithEmailAndPassword(email: email, password: pass).then((authUser){
      firebaseUser = authUser.user;
      onSuccess();
    }).catchError((err){
      onFail();
    });

    isLoading = false;
    notifyListeners();
  }

  void recoverPass({ @required String email }) {
    _auth.sendPasswordResetEmail(email: email);
  }

  Future<Null> _loadUserdata() async {
    if(firebaseUser == null) {
      firebaseUser = await _auth.currentUser();
    }
    if(firebaseUser != null) {
      if(userData['name'] == null) {
        DocumentSnapshot docUser =
          await Firestore.instance.collection('users').document(firebaseUser.uid).get();

        userData = docUser.data;
      }
    }

    notifyListeners();
  }

  void signOut () async {
    await _auth.signOut();
    firebaseUser = null;
    userData = Map();

    notifyListeners();
  }

  bool isLoggedIn(){
    print(firebaseUser);
    print(userData['name']);
    print(userData);
    return firebaseUser != null;
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance.collection('users').document(firebaseUser.uid).setData(userData);
  }

}