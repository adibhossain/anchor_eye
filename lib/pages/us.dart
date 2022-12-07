import 'package:flutter/material.dart';
import 'navbar.dart';

class us extends StatefulWidget {
  @override
  _usState createState() => _usState();
}

class _usState extends State<us> {
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
          args['bangla']?'আমাদের সম্পর্কে জানুন':'About Us',
          style: TextStyle(
            fontSize: 25,
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
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //SizedBox(height: 60),
              SizedBox(height: 20),
              // SizedBox(height: 1),
              Image.asset('assets/us'+(args['bangla']?1:0).toString()+'.JPG'),
              // height:150,
              // width:100,
              // SizedBox(height: 0),

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
