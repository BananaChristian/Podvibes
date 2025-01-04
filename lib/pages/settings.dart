import 'package:flutter/material.dart';
import 'package:podvibes/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider= Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar:AppBar(
        title:Text('Settings'),
        centerTitle: true,
      ),
      body:Container(
        color:Theme.of(context).colorScheme.surface,
        child: ListView(
          children:[
            SwitchListTile(
              activeColor: Colors.amber,
              value:themeProvider.isDarkMode,
              onChanged:(bool value){
                themeProvider.toggleThemes();
              },
              title: Text(
                'Dark mode',
                style:TextStyle(color:Theme.of(context).colorScheme.inversePrimary)
                )
            ),
          ]
        ),
      )
    );
  }
}