import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/splash.dart';
import 'pages/login.dart';
import 'pages/main_menu.dart';
import 'pages/signup.dart';
import 'pages/add_farm.dart';
import 'pages/specific_farm.dart';
import 'pages/verification.dart';
import 'pages/yourfishfarms.dart';
import 'pages/control_panel.dart';
import 'pages/helpninfo.dart';
import 'pages/manual1.dart';
import 'pages/manual2.dart';
import 'pages/us.dart';
import 'pages/dashboard_details.dart';
import 'pages/update_farm.dart';
import 'pages/suggestion.dart';
import 'pages/prediction.dart';



void main() {
  runApp(MaterialApp(
      initialRoute: '/prediction',
      routes: {
        '/': (context) => Splash(),
        '/home': (context) => Home(),
        '/login': (context) => Login(),
        '/main_menu': (context) => MainMenu(),
        '/signup': (context) => SignUp(),
        '/control_panel': (context) => ControlPanel(),
		    '/add_farm': (context) => Add_farm(),
		    '/specific_farm': (context) => SpecificFarm(),
		    '/verification': (context) => Verification(),
        '/yourfishfarms': (context) => Your_fishfarm(),
        '/helpninfo': (context) => helpninfo(),
        '/manual1': (context) => Manual1(),
        '/manual2': (context) => manual2(),
        '/us': (context) => us(),
        '/test': (context) => DashDetail(),
        '/update_farm': (context) => Update_farm(),
            '/suggestion': (context) => Suggestion(),
            '/prediction': (context) => Prediction(),




      }
  ));
}

