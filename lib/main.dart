import 'package:flutter/material.dart';
import 'package:podvibes/pages/login.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title:'PodVibes',
      home:LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}