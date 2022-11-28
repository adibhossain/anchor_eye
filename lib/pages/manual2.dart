import 'package:flutter/material.dart';

class manual2 extends StatefulWidget {

  @override
  _manual2State createState() => _manual2State();
}

class _manual2State extends State<manual2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF186B9A),
        centerTitle: true,
        title: Text(
          'ব্যবহার বিধি',
          style: TextStyle(
            fontSize: 30,
            color: Color(0xFFB9E6FA),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Color(0xFFB9E6FA),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //SizedBox(height: 60),
              SizedBox(height: 50),
              Image.asset('assets/manual2.JPG'),
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
