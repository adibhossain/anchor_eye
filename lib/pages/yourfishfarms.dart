import 'package:flutter/material.dart';
import 'navbar.dart';

class Your_fishfarm extends  StatefulWidget {
 // const Login({Key? key}) : super(key: key);
  @override
  _YourFishFarm createState() => _YourFishFarm();
}

class _YourFishFarm extends State<Your_fishfarm>{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); //this
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF99CDE3),
      appBar: AppBar(
        backgroundColor: Color(0xFF186B9A),
        centerTitle: true,
        title: Text(
          'আপনার খামারসমূহ',
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
              Image(
                image: AssetImage('assets/main_icon.png'),
                height: 150.0,
                width: 150.0,
              ),
              SizedBox(height:45),
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    minimumSize: const Size(200, 30),
                    foregroundColor: Color(0xFF0A457C),
                    backgroundColor: Color(0xFFD2ECF2),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/specific_farm');
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0,20,0,15),
                    child: Text(
                      'রুই খামার',
                      style: TextStyle(
                        fontSize: 25.0,
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
                    minimumSize: const Size(200, 30),
                    foregroundColor: Color(0xFF0A457C),
                    backgroundColor: Color(0xFFD2ECF2),
                  ),
                  onPressed: () { },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0,20,0,15),
                    child: Text(
                      'পাঙ্গাশ খামার',
                      style: TextStyle(
                        fontSize: 25.0,
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
                    minimumSize: const Size(170, 30),
                    foregroundColor: Color(0xFFD2ECF2),
                    backgroundColor: Color(0xFF186B9A),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/add_farm');
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0,10,0,5),
                    child: Text(
                      'খামার যোগ করুন',
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

