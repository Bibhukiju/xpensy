import 'package:flutter/material.dart';
import 'package:xpensy/pages/homescreen.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: ThemeData(
        primaryColor: Colors.deepPurple.shade900,
        accentColor: Colors.red
      ),
    );
  }
}
