import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/splash.dart';

void main() {
  runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Splash(),
        '/home': (context) => Home(),
      }
  ));
}

