import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Map args = {};
  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      backgroundColor: Color(0xFF99CDE3),
      body: SafeArea(
        child: Center(
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
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 8),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: args['bangla']?'নাম':'Name',
                    filled: true,
                    fillColor: Color(0xFFD2ECF2),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 8),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: args['bangla']?'মোবাইল':'Phone No.',
                    filled: true,
                    fillColor: Color(0xFFD2ECF2),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 8),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: args['bangla']?'পাসওয়ার্ড':'Password',
                    filled: true,
                    fillColor: Color(0xFFD2ECF2),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 8),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: args['bangla']?'পাসওয়ার্ড নিশ্চিত করুন':'Conform Password',
                    filled: true,
                    fillColor: Color(0xFFD2ECF2),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    minimumSize: const Size(170, 30),
                    foregroundColor: Color(0xFFD2ECF2),
                    backgroundColor: Color(0xFF186B9A),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/verification', arguments: {
                      'bangla': args['bangla'],
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0,10,0,5),
                    child: Text(
                      args['bangla']?'সাইনআপ':'Sign Up',
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
