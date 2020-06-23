import 'dart:async';

import 'package:flutter/material.dart';
import 'package:xpensy/pages/homescreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[300],
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Colors.teal,
                  backgroundImage: AssetImage("assets/images/applogo.png"),
                  radius: 50,
                ),
              )),
          Expanded(
              child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Your assistant to  help you to track your Expenses",
                    style: TextStyle(
                        color: Colors.white,
                        textBaseline: TextBaseline.alphabetic,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
