import 'package:flutter/material.dart';
import 'navbar.dart';

class Suggestion_fish extends StatefulWidget {
  const Suggestion_fish({Key? key}) : super(key: key);

  @override
  _Suggestion_fishState createState() => _Suggestion_fishState();
}

class _Suggestion_fishState extends State<Suggestion_fish> {
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
                'ড্যাশবোর্ড - পরামর্শ',
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
                image: AssetImage('assets/light.png'),
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
                      child: Text(' ১) পানির পিএইচ হঠ্যাৎ করে কমে গিয়েছে শতাংশে ২০০ গ্রাম হারে ডলোমাইট দিতেহবে. \n'
                          'পিএইচ ফ্লাকচুয়েশন এর উপর নির্ভরকরে পর পর ৩ দিন ডলোমাইট দিতে হবে.\n '
                          ' ২) রোগ প্রতিরোধের জন্য একরপ্রতি ৪৫-৬০ কেজি চুন প্রয়োগ করতে পারেন। \n '
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
