import 'package:flutter/material.dart';
import 'navbar.dart';

class us extends StatefulWidget {
  const us({Key? key}) : super(key: key);

  @override
  _usState createState() => _usState();
}

class _usState extends State<us> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); //this
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context,'/manual2');
        },
        child: Image(
          image: AssetImage('assets/next.png'),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Color(0xFFB9E6FA),
      appBar: AppBar(
        backgroundColor: Color(0xFF186B9A),
        centerTitle: true,
        title: Text(
          'আমাদের সম্পর্কে জানুন',
          style: TextStyle(
            fontSize: 25,
            color: Color(0xFFB9E6FA),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      key: _scaffoldKey, //this
      drawer: NavBar(), //this
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //SizedBox(height: 60),
              SizedBox(height: 20),
              // SizedBox(height: 1),
              Image.asset('assets/us.JPG'),
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
