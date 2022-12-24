import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app_alex_c7_fri/ui/home/home_screen.dart';
import 'package:flutter_chat_app_alex_c7_fri/ui/login/login_screen.dart';
import 'package:flutter_chat_app_alex_c7_fri/ui/register/register_screen.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        RegisterScreen.routeName : (context) => RegisterScreen(),
        LoginScreen.routeName : (context) => LoginScreen(),
        HomeScreen.routeName : (context) => HomeScreen()
      },
      initialRoute: LoginScreen.routeName,
    );
  }
}
