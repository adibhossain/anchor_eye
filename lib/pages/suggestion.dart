import 'package:flutter/material.dart';
import 'navbar.dart';

class Suggestion extends StatefulWidget {
  const Suggestion({Key? key}) : super(key: key);

  @override
  _SuggestionState createState() => _SuggestionState();
}

class _SuggestionState extends State<Suggestion> {
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
            'ড্যাশবোর্ড - পরামর্শ',
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
                image: AssetImage('assets/light.png'),
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
              child: Text(' ১) পানির পিএইচ হঠ্যাৎ করে কমে গিয়েছে শতাংশে ২০০ গ্রাম হারে ডলোমাইট দিতেহবে. \n'
                  'পিএইচ ফ্লাকচুয়েশন এর উপর নির্ভরকরে পর পর ৩ দিন ডলোমাইট দিতে হবে.\n '
               ' ২) রোগ প্রতিরোধের জন্য একরপ্রতি ৪৫-৬০ কেজি চুন প্রয়োগ করতে পারেন। \n '
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