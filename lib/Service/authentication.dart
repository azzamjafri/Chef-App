import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:recipe_app/Category/categories.dart';
import 'package:recipe_app/HomePage/login.dart';
import 'package:recipe_app/HomePage/registration.dart';



class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;


  


  // Auth Change
  Stream<FirebaseUser> get user {
    return _auth.onAuthStateChanged;
  }

  // sign in anon
  Future signInAnon() async {

    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return user;
    }catch(e){
      print(e.toString() + "...................");
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    email = email.trim();
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    }catch(e) {
      print(e.toString() + "...................");
      return null;
    }
  }


  // signOut
  Future signOut() async {
      try{
        return await _auth.signOut();
      }catch(e){
        print(e.toString() + "...................");
        return null;

      }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    }catch(e){
      print(e.toString() + "...................");
      return null;
    }
  }


  // Reset password and email
  Future resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  handleAuth() {

    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if(snapshot.hasData) return Category();
        else
          return Login();
      },
    );
  }

}