import 'package:flutter/material.dart';
import 'navbar.dart';

class settings extends StatefulWidget {
  @override
  _settingsState createState() => _settingsState();
}

class _settingsState extends State<settings> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); //this
  bool _hasBeenPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB9E6FA),
      appBar: AppBar(
        backgroundColor: Color(0xFF186B9A),
        centerTitle: true,
        title: Text(
          'সেটিংস',
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

            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/sett.JPG'),
              SizedBox(height:5),
              Container(

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    minimumSize: const Size(200, 80),
                    foregroundColor: Color(0xFF0A457C),
                    backgroundColor: Color(0xFFD2ECF2),
                  ),
                  onPressed: () {
                    foregroundColor: Color(0xFF0A458B);
                    setState() {
                      _hasBeenPressed = !_hasBeenPressed;
                      // backgroundColor: Color(0xFFD2ECF2),
                    };
                  },

                  child: Container(
                    padding: EdgeInsets.fromLTRB(0,10,0,5),
                    child: Text(
                      'বাংলা',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    minimumSize: const Size(200, 80),
                    foregroundColor: Color(0xFF0A457C),
                    backgroundColor: Color(0xFFD2ECF2),
                  ),
                  onPressed: () {
                    foregroundColor: Color(0xFF0A458B);
                    setState() {
                      _hasBeenPressed = !_hasBeenPressed;
                      // backgroundColor: Color(0xFFD2ECF2),
                    };
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0,10,0,5),
                    child: Text(
                      'English',
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
