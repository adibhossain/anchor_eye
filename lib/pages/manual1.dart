import 'package:flutter/material.dart';

class Manual1 extends StatefulWidget {
   @override
   _Manual1State createState() => _Manual1State();
}

class _Manual1State extends State<Manual1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB9E6FA),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //SizedBox(height: 60),
              SizedBox(height: 20),
              Container(
                child: Text(
                  'ব্যবহার বিধি',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xFF0A457C),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // SizedBox(height: 1),
              Image.asset('assets/manual1.JPG'),
              // SizedBox(height: 0),
              Container(
                child: Text(
                  '',
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Color(0xFF0A457C),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Container(
              //   child: Text(
              //     '',
              //     style: TextStyle(
              //       fontSize: 25.0,
              //       color: Color(0xFF0A457C),
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              SizedBox(height: 0),
              // Container(
              //   // child: SpinKitRing(
              //   //   color: Color(0xFF0A457C),
              //   //   size: 50.0,
              //   // ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
