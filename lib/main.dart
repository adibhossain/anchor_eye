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
import 'pages/manual.dart';
import 'pages/us.dart';
import 'pages/dashboard_details.dart';
import 'pages/dashboard.dart';
import 'pages/update_farm.dart';
import 'pages/suggestion.dart';
import 'pages/prediction.dart';
import 'pages/contact.dart';
import 'pages/settings.dart';



void main() {
  runApp(MaterialApp(
      initialRoute: '/',
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
        '/manual': (context) => Manual(),
        '/us': (context) => us(),
        '/dashdetail': (context) => DashDetail(),
        '/dashboard': (context) => Dashboard(),
        '/update_farm': (context) => Update_farm(),
        '/suggestion': (context) => Suggestion(),
        '/prediction': (context) => Prediction(),
        '/contact': (context) => contact(),
        '/settings': (context) => settings(),




      }
  ));
}

