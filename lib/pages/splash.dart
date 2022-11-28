import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  void loadHome() async {
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushNamed(context, '/home');
    });
  }

  @override
  void initState() {
    super.initState();
    loadHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF99CDE3),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //SizedBox(height: 60),
              Container(
                child: Text(
                    'অ্যাংকর আই',
                  style: TextStyle(
                    fontSize: 50.0,
                    color: Color(0xFF0A457C),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Image.asset('assets/main_icon.png'),
              SizedBox(height: 25),
              Container(
                child: Text(
                  'অ্যাংকর আই এS',
                  style: TextStyle(
                      fontSize: 40.0,
                      color: Color(0xFF0A457C),
                      fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                child: Text(
                  'আপনাকে স্বাগতম',
                  style: TextStyle(
                      fontSize: 40.0,
                      color: Color(0xFF0A457C),
                      fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 25),
              Container(
                child: SpinKitRing(
                  color: Color(0xFF0A457C),
                  size: 50.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
