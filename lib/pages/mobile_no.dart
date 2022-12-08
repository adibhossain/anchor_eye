import 'package:flutter/material.dart';

class Mobile_No extends StatefulWidget {
  @override
  _Mobile_NoState createState() => _Mobile_NoState();
}

class _Mobile_NoState extends State<Mobile_No> {
  Map args = {};
  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      backgroundColor: Color(0xFF99CDE3),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  args['bangla']?'অ্যাংকর আই':'Anchor Eye',
                  style: TextStyle(
                    fontSize: 45.0,
                    color: Color(0xFF186B9A),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Image(
                  image: AssetImage('assets/main_icon.png'),
                  height: 150.0,
                  width: 150.0,
                ),
                SizedBox(height: 60),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 8),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: args['bangla']?'মোবাইল':'Mobile No.',
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
                    onPressed: () {
                      Navigator.pushNamed(context, '/verification_forgot_pass', arguments: {
                        'bangla': args['bangla'],
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0,10,0,5),
                      child: Text(
                        args['bangla']?'যাচাইকরণ কোড পাঠান':'Send Verification Code',
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
      ),
    );
  }
}
