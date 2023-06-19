import 'package:flutter/material.dart';
import 'navbar.dart';

class contact extends StatefulWidget {
  @override
  _contactState createState() => _contactState();
}

class _contactState extends State<contact> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); //this
  Map args = {};
  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      backgroundColor: Color(0xFFB9E6FA),
      appBar: AppBar(
        backgroundColor: Color(0xFF186B9A),
        centerTitle: true,
        title: Text(
          args['bangla']?'যোগাযোগ করুন':'Contact Us',
          style: TextStyle(
            fontSize: 27,
            color: Color(0xFFB9E6FA),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      key: _scaffoldKey, //this
      drawer: NavBar(bangla: args['bangla']), //this
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 300,
                child: Text(
                  args['bangla']?'ফোন: ০১৭০৩০৬১৫৩৩':'Hotline 1: +8801776474084',
                  style: TextStyle(
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: 300,
                child: Text(
                  args['bangla']?'ফোন: ০১৭০৩০৬১৫৩৩':'Hotline 2: +8801969844062',
                  style: TextStyle(
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: 300,
                child: Text(
                  args['bangla']?'ফোন: ০১৭০৩০৬১৫৩৩':'Hotline 3: +8801743097197',
                  style: TextStyle(
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: 300,
                child: Text(
                  args['bangla']?'ফোন: ০১৭০৩০৬১৫৩৩':'Hotline 4: +8801911092794',
                  style: TextStyle(
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: 300,
                child: Text(
                  args['bangla']?'ফোন: ০১৭০৩০৬১৫৩৩':'Hotline 5: +8801700808277',
                  style: TextStyle(
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
