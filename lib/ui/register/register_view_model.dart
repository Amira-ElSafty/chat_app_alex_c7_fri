import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app_alex_c7_fri/database/database_utils.dart';
import 'package:flutter_chat_app_alex_c7_fri/firebase_errors.dart';
import 'package:flutter_chat_app_alex_c7_fri/model/my_user.dart';
import 'package:flutter_chat_app_alex_c7_fri/ui/register/register_navigator.dart';

/// provider
class RegisterViewModel extends ChangeNotifier {
  late RegisterNavigator navigator  ;
  // logic
  void registerFirebaseAuth(String email, String password , String firstName ,
      String lastName , String userName) async {
    // show loading
    navigator.showLoading();
    try {
      final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      /// save data
      var user = MyUser(
          id: result.user?.uid ?? '',
          firstName: firstName,
          lastName: lastName,
          userName: userName,
          email: email);
      print('id: ${result.user?.uid }');
      var dataUser = await DatabaseUtils.registerUser(user);
      /// hide loading
      navigator.hideLoading();
      /// show message
      navigator.showMessage('Register successfully');
      navigator.navigateToHome(user);
    } on FirebaseAuthException catch (e) {

      if (e.code == FirebaseErrors.weakPassword) {
        /// hide loading
        navigator.hideLoading();
        /// show message
        navigator.showMessage('The password provided is too weak.');
        print('The password provided is too weak.');
      } else if (e.code == FirebaseErrors.emailAlreadyInUse) {
        /// hide loading
        navigator.hideLoading();
        /// show message
        navigator.showMessage('The account already exists for that email.');
        print('The account already exists for that email.');
      }
    } catch (e) {
      /// hide loading
      navigator.hideLoading();
      /// show message
      navigator.showMessage('Something went wrong');
      print(e);
    }
  }

}
