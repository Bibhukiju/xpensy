import 'package:flutter/material.dart';
import 'package:xpensy/pages/splashScreen.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme:
          ThemeData(primaryColor: Colors.teal, accentColor: Colors.blueAccent),
    );
  }
}
