import 'package:flutter/material.dart';
import 'navbar.dart';

class Prediction extends StatefulWidget {
  const Prediction({Key? key}) : super(key: key);

  @override
  _PredictionState createState() => _PredictionState();
}

class _PredictionState extends State<Prediction> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); //this
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF99CDE3),
      appBar: AppBar(
        backgroundColor: Color(0xFF186B9A),
        centerTitle: true,
        title: Text(
          'রুই খামার',
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
              Text(
                'ড্যাশবোর্ড - পূর্বাভাস',
                style: TextStyle(
                  fontSize: 30.0,
                  color: Color(0xFF186B9A),
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 65, vertical: 5),
              ),
              Image(
                image: AssetImage('assets/fortune.png'),
                height: 70.0,
                width: 60.0,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 65, vertical: 5),
              ),
              Container(
                child: Card(
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      debugPrint('Card tapped.');
                    },
                    child: const SizedBox(
                      width: 300,
                      height: 250,
                      child: Text(' ১) মাছের বৃদ্ধি কমে যেতে পারে \n'

                          ' ২)রুই মাছের এখনকার চেয়ে ৫০ গ্রাম বেশি খাবারের প্রয়োজন হতে পারে \n '
                          ' ৩) বর্তমান শুষ্ক আবহাওয়া ২ সপ্তাহ থাকবে '
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
