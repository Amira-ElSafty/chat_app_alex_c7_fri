import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app_alex_c7_fri/database/database_utils.dart';
import 'package:flutter_chat_app_alex_c7_fri/model/my_user.dart';

class UserProvider extends ChangeNotifier{
  MyUser? user ;
  User? firebaseUser ;

  UserProvider(){
    firebaseUser = FirebaseAuth.instance.currentUser ;
    initUser();
  }
  initUser()async{
    if(firebaseUser != null){
      user = await DatabaseUtils.getUser(firebaseUser?.uid ?? '');
    }
  }
}