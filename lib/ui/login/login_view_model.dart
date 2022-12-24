import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app_alex_c7_fri/firebase_errors.dart';
import 'package:flutter_chat_app_alex_c7_fri/ui/login/login_navigator.dart';

class LoginViewModel extends ChangeNotifier{
  late LoginNavigator navigator ;
  void loginFirebaseAuth(String email , String password)async{
    try {
      // show loading
      navigator.showLoading();
      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      // hide loading
      navigator.hideLoading();
      // show message
      navigator.showMessage('Login successfully');
      print('id: ${result.user?.uid}');
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseErrors.userNotFound) {
        // hide loading
        navigator.hideLoading();
        // show message
        navigator.showMessage('No user found for that email.');
        print('No user found for that email.');
      } else if (e.code == FirebaseErrors.wrongPassword) {
        // hide loading
        navigator.hideLoading();
        // show message
        navigator.showMessage('Wrong password provided for that user.');
        print('Wrong password provided for that user.');
      }
    }
  }
}