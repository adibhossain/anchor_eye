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
            crossAxisAlignment: CrossAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //SizedBox(height: 60),
              SizedBox(height: 20),
              // SizedBox(height: 1),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                  child: Image.asset('assets/us.jpg')
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 3),
                child: Text(
                  args['bangla']?'আমরা মিলিটারি ইনস্টিটিউট অফ সায়েন্স অ্যান্ড টেকনোলজির কম্পিউটার সায়েন্স অ্যান্ড ইঞ্জিনিয়ারিং বিভাগের শিক্ষার্থী ।'
                      :'We are a team of five from Computer Science and Engineering Department, Military Institute of Science and Technology.',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF186B9A),
                  ),
                  //textAlign: TextAlign.justify,
                  softWrap: true,
                ),
              ),
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
