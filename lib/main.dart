import 'package:flutter/material.dart';
import 'home_page.dart';
import 'edit_profile.dart';
import 'find_location.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      // hidden banner debug
      debugShowCheckedModeBanner: false,

      // membuat routing screen
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/edit-profile': (context) => EditProfile(),
        '/find-location': (context) => FindLocation(),
      },

    );
  }
}

