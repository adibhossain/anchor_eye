import 'package:bcrypt/bcrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_admin/firebase_admin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../services/auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loading = false;
  Map args = {};
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  final phoneController = TextEditingController();
  final passController = TextEditingController();
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
                          controller: phoneController,
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
                          controller: passController,
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
                            maximumSize: const Size(210, 50),
                            foregroundColor: Color(0xFFD2ECF2),
                            backgroundColor: Color(0xFF186B9A),
                          ),
                          onPressed: () async{
                            if(loading) return;
                            loading=true;
                            setState(() {});
                            print(phoneController.text);
                            await FirebaseFirestore.instance.collection('users').doc(phoneController.text).get().then((documentSnapshot) async {
                              if (documentSnapshot.exists){
                                bool ok = false;
                                String hashedpass =  documentSnapshot.get('pass');
                                print(hashedpass);
                                ok = BCrypt.checkpw(passController.text, hashedpass);
                                print('here');
                                if(ok) {
                                  String old_uid = await documentSnapshot.get('uid');
                                  await FirebaseAuth.instance.verifyPhoneNumber(
                                    phoneNumber: phoneController.text,
                                    verificationCompleted: (_){},
                                    verificationFailed: (e){print(e);},
                                    codeSent: (String verificationId, int? token){
                                      Navigator.pushNamed(context, '/verification', arguments: {
                                        'bangla': args['bangla'],
                                        'verificationId': verificationId,
                                        'phone': phoneController.text,
                                        'pass': passController.text,
                                        'old_uid': old_uid,
                                        'from': 'login',
                                        'goto': '/main_menu',
                                      });
                                    },
                                    codeAutoRetrievalTimeout: (e){print(e);},
                                  );
                                  ////done here, rest templates for later
                                }
                                else {
                                  print(passController.text);
                                  print('password not matched');
                                }
                              }
                              else{
                                print('Please register first');
                              }
                            }).catchError((error){
                              print('Error retrieving document: $error');
                            });
                            loading=false;
                            setState(() {});
                          },

                          child: Container(
                            padding: EdgeInsets.fromLTRB(0,10,0,5),
                            child: loading?SpinKitRing(
                              color: Color(0xFFD2ECF2),
                              size: 30.0,
                            )
                                :Text(
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
