import 'package:flutter/material.dart';
import 'package:flutter_chat_app_alex_c7_fri/ui/register/register_screen.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        RegisterScreen.routeName : (context) => RegisterScreen()
      },
      initialRoute: RegisterScreen.routeName,
    );
  }
}
