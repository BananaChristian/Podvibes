import 'package:flutter/material.dart';
import 'package:podvibes/pages/login.dart';
import 'package:podvibes/pages/register_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  bool isRegistered=false;
  @override
  Widget build(BuildContext context) {
    if(isRegistered){
      return LoginPage(togglePages: togglePages);
    }else{
      return RegisterPage(togglePages: togglePages,);
    }
  }

  void togglePages(){
    setState((){
      isRegistered=!isRegistered;
    });
  }
}