import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:podvibes/pages/home.dart';
import 'package:podvibes/pages/login_or_register.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (context, snapshot){
          if(snapshot.hasData){
            return const Home();
          }else{
            return const LoginOrRegisterPage();
          }
        }
      )
    );
  }
}