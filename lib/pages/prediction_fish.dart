import 'package:flutter/material.dart';
import 'navbar.dart';

class Prediction_fish extends StatefulWidget {
  const Prediction_fish({Key? key}) : super(key: key);

  @override
  _Prediction_fishState createState() => _Prediction_fishState();
}

class _Prediction_fishState extends State<Prediction_fish> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); //this
  int i=0;
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
      drawer: NavBar(bangla: true), //this
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'মাছের বৃদ্ধি',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Image.asset('assets/slide'+i.toString()+'.png'),
                    iconSize: 40,
                    onPressed: () {
                      i++;
                      i%=2;
                      setState(() {});
                    },
                  ),
                  Text(
                    'জলের গুণমান সূচক',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 65, vertical: 35),
              ),
              Image(
                image: AssetImage('assets/fortune.png'),
                height: 70.0,
                width: 60.0,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 65, vertical: 0),
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 65, vertical: 20),
              ),

            ],
          ),


        ),
      ),
    );

  }
}
