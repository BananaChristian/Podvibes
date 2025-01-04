import 'package:flutter/material.dart';
import 'package:podvibes/pages/login_or_register.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title:'PodVibes',
      home:LoginOrRegisterPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}