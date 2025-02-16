import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:podvibes/audio/audio_player_provider.dart';
import 'package:podvibes/auth/auth_gate.dart';
import 'package:podvibes/firebase_options.dart';
import 'package:podvibes/models/miniplayer_state.dart';
import 'package:podvibes/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(create: (context) => AudioPlayerProvider()),
        ChangeNotifierProvider(create: (context) => MiniplayerState())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return MaterialApp(
        title: 'PodVibes',
        home: const AuthGate(),
        debugShowCheckedModeBanner: false,
        theme: themeProvider.themeData,
      );
    });
  }
}
