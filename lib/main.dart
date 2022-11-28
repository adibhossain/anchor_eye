import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/splash.dart';
import 'pages/login.dart';

void main() {
  runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Splash(),
        '/home': (context) => Home(),
        '/login': (context) => Login(),
      }
  ));
}

