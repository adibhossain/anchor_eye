import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/splash.dart';
import 'pages/login.dart';
import 'pages/main_menu.dart';
import 'pages/signup.dart';
import 'pages/add_farm.dart';
import 'pages/specific_farm.dart';
import 'pages/yourfishfarms.dart';

void main() {
  runApp(MaterialApp(
      initialRoute: '/yourfishfarms',
      routes: {
        '/': (context) => Splash(),
        '/home': (context) => Home(),
        '/login': (context) => Login(),
        '/main_menu': (context) => MainMenu(),
        '/signup': (context) => SignUp(),
		'/add_farm': (context) => Add_farm(),
        '/yourfishfarms': (context) => Your_fishfarm(),
		'/specific_farm': (context) => SpecificFarm(),
      }
  ));
}

