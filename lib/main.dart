import 'package:flutter/material.dart';
import 'package:podvibes/pages/login_or_register.dart';
import 'package:podvibes/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(
    ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child:const MyApp(),
    )
  );
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder:(context,themeProvider,child){
        return MaterialApp(
        title:'PodVibes',
        home:const LoginOrRegisterPage(),
        debugShowCheckedModeBanner: false,
        theme:themeProvider.themeData,
      );
      }
    );
  }
}