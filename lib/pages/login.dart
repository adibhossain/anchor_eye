import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF99CDE3),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'অ্যাংকর আই',
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 8),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'ইউজারনেম',
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
                    hintText: 'পাসওয়ার্ড',
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
                    Navigator.pushNamed(context, '/main_menu');
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0,10,0,5),
                    child: Text(
                      'লগ ইন',
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
