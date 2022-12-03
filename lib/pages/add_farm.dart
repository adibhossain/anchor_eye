import 'package:flutter/material.dart';
import 'navbar.dart';

class Add_farm extends StatefulWidget {
  const Add_farm({Key? key}) : super(key: key);

  @override
  _Add_farmState createState() => _Add_farmState();
}

class _Add_farmState extends State<Add_farm> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); //this
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF99CDE3),
      appBar: AppBar(
          backgroundColor: Color(0xFF186B9A),
        centerTitle: true,
        title: Text(
          'খামার যোগ করুন',
          style: TextStyle(
            fontSize: 30.0,
            color: Color(0xFFD2ECF2),
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
            children: <Widget>[
              Image(
                image: AssetImage('assets/main_icon.png'),
                height: 150.0,
                width: 150.0,
              ),
              SizedBox(height: 50),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 8),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'খামারের নাম',
                    filled: true,
                    fillColor: Color(0xFFD2ECF2),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 8),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'মাছের ধরন',
                    filled: true,
                    fillColor: Color(0xFFD2ECF2),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    minimumSize: const Size(170, 30),
                    foregroundColor: Color(0xFFD2ECF2),
                    backgroundColor: Color(0xFF186B9A),
                  ),
                  onPressed: () { },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0,10,0,5),
                    child: Text(
                      'যোগ করুন',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
