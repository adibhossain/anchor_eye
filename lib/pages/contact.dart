import 'package:flutter/material.dart';
// import 'package:getwidget/getwidget.dart';
import 'navbar.dart';

class contact extends StatefulWidget {
  @override
  _contactState createState() => _contactState();
}

class _contactState extends State<contact> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); //this
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Navigator.pushNamed(context,'/manual2');
      //   },
      //   child: Image(
      //     image: AssetImage('assets/next.png'),
      //   ),
      //   backgroundColor: Colors.white,
      // ),
      backgroundColor: Color(0xFFB9E6FA),
      appBar: AppBar(
        backgroundColor: Color(0xFF186B9A),
        centerTitle: true,
        title: Text(
          'যোগাযোগ করুন',
          style: TextStyle(
            fontSize: 27,
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
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //SizedBox(height: 60),
              SizedBox(height: 50),
              // SizedBox(height: 1),
              Image.asset('assets/contact.JPG'),
              SizedBox(height: 30),
              // children:
              Row(
                  children: <Widget>[
                    SizedBox(width: 3),
                IconButton(
                  icon: Image.asset('assets/fb.png'),
                  iconSize: 100,
                  onPressed: () {},
                ),
                    SizedBox(width: 1),
                IconButton(
                  icon: Image.asset('assets/wa.png'),
                  iconSize: 100,
                  onPressed: () {},
                ),
                    SizedBox(width: 1),
                IconButton(
                  icon: Image.asset('assets/ig.png'),
                  iconSize: 100,
                  onPressed: () {},
                ),

                    SizedBox(width: 1),

                  ]
              ),
              // GFIconButton(
              //   onPressed: (){},
              //   icon: Icon(Icons.facebook),
              // ),
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
