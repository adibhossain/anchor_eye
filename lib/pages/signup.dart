import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Map args = {};
  final auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final passController = TextEditingController();
  final confirmpassController = TextEditingController();
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
                SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 100, vertical: 8),
                        child: TextFormField(
                          controller: nameController,
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
                        child: TextFormField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: args['bangla']?'মোবাইল':'Phone No.',
                            filled: true,
                            fillColor: Color(0xFFD2ECF2),
                          ),
                          //keyboardType: TextInputType.number,
                        ),
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
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 100, vertical: 8),
                        child: TextFormField(
                          obscureText: true,
                          controller: confirmpassController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: args['bangla']?'পাসওয়ার্ড নিশ্চিত করুন':'Confirm Password',
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
                          onPressed: () async {
                            if(passController.text != confirmpassController.text) return;
                            final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
                            await userCollection.doc(phoneController.text).get().then((documentSnapshot) {
                              if (documentSnapshot.exists){
                                print('Already registered');
                                return;
                              }
                              else{
                                print('User not registered.');
                                auth.verifyPhoneNumber(
                                  phoneNumber: phoneController.text,
                                  verificationCompleted: (_){},
                                  verificationFailed: (e){print(e);},
                                  codeSent: (String verificationId, int? token){
                                    Navigator.pushNamed(context, '/verification', arguments: {
                                      'bangla': args['bangla'],
                                      'verificationId': verificationId,
                                      'phone': phoneController.text,
                                      'name': nameController.text,
                                      'pass': passController.text,
                                      'confirmpass': confirmpassController.text,
                                      'from': 'signup',
                                      'goto': '/main_menu',
                                    });
                                  },
                                  codeAutoRetrievalTimeout: (e){print(e);},
                                );
                              }
                            }).catchError((error){
                              print('Error retrieving document: $error');
                              return;
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
