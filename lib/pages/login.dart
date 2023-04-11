import 'package:flutter/material.dart';
import '../services/auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Map args = {};
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  //final _LoginKey = GlobalKey<LoginState>();
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
                //key: _LoginKey,
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
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 100, vertical: 8),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: args['bangla']?'মোবাইল নম্বর':'Phone No.',
                            filled: true,
                            fillColor: Color(0xFFD2ECF2),
                          ),
                        ),
                        //validator: (value){
                          //if(value!.isEmpty){
                            //return 'Enter Phone Number';
                          //}
                          //return null;
                        //}
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 100, vertical: 8),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: args['bangla']?'পাসওয়ার্ড':'Password',
                            filled: true,
                            fillColor: Color(0xFFD2ECF2),
                          ),
                        ),
                        //validator: (value){
                        //if(value!.isEmpty){
                        //return 'Enter Password';
                        //}
                        //return null;
                        //}
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
                          onPressed: () async{
                            dynamic result = await _auth.signInAnon();
                            if(result == null){
                              print('error signing in');
                            } else {
                              print('signed in');
                              print(result);
                              Navigator.pushReplacementNamed(context, '/main_menu', arguments: {
                                'bangla': args['bangla'],
                              });
                            }
                          },

                          child: Container(
                            padding: EdgeInsets.fromLTRB(0,10,0,5),
                            child: Text(
                              args['bangla']?'লগ ইন':'Log In',
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/mobile_no', arguments: {
                            'bangla': args['bangla'],
                            'goto': '/verification',
                            'gototo': '/new_pass',
                            'gotototo': '/login',
                          });
                        },
                        child: Text(
                          args['bangla']?'পাসওয়ার্ড ভুলে গেছেন?':'Forgot Password?',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
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
