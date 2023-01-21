import 'package:flutter_chat_app_alex_c7_fri/model/my_user.dart';

abstract class LoginNavigator{
  void showLoading();
  void hideLoading();
  void showMessage(String message);
  void navigateToHome(MyUser user);
}