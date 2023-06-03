import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool loading = false;
  String error_msg='';
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 65,
                              child: TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: args['bangla']?'+৮৮০':'+880',
                                  filled: true,
                                  fillColor: Color(0xFFD2ECF2),
                                ),
                                //keyboardType: TextInputType.number,
                              ),
                            ),
                            Container(
                              width: 118,
                              child: TextFormField(
                                controller: phoneController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: args['bangla']?'মোবাইল':'Phone No.',
                                  filled: true,
                                  fillColor: Color(0xFFD2ECF2),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
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
                            maximumSize: const Size(210, 50),
                            foregroundColor: Color(0xFFD2ECF2),
                            backgroundColor: Color(0xFF186B9A),
                          ),
                          onPressed: () async {
                            if(loading) return;
                            loading=true;
                            setState(() {});
                            if(nameController.text=='' || phoneController.text=='' || passController.text=='' || confirmpassController.text==''){
                              error_msg=(args['bangla']?'ফর্ম পূরণ করুন':'Please fill up the form');
                              loading=false;
                              setState(() {});
                              return;
                            }
                            if(phoneController.text.length!=10){
                              error_msg=(args['bangla']?'দশ সংখ্যার ফোন নম্বর লিখুন':'Please enter 10 digit phone no.');
                              loading=false;
                              setState(() {});
                              return;
                            }
                            var phoneno='+880'+phoneController.text;
                            if(passController.text != confirmpassController.text){
                              error_msg=(args['bangla']?"পাসওয়ার্ড মিলছে না":"Passwords do not match");
                              loading=false;
                              setState(() {});
                              return;
                            }
                            final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
                            await userCollection.doc(phoneno).get().then((documentSnapshot) async {
                              if (documentSnapshot.exists){
                                //print('Already registered');
                                error_msg=(args['bangla']?'এই ফোন নম্বর ইতিমধ্যে নিবন্ধিত আছে':'This phone number is already registered');
                                return;
                              }
                              else{
                                print('User not registered.');
                                error_msg='';
                                await auth.verifyPhoneNumber(
                                  phoneNumber: phoneno,
                                  verificationCompleted: (_){},
                                  verificationFailed: (e){print(e);},
                                  codeSent: (String verificationId, int? token){
                                    Navigator.pushNamed(context, '/verification', arguments: {
                                      'bangla': args['bangla'],
                                      'verificationId': verificationId,
                                      'phone': phoneno,
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
                              args['bangla']?'সাইনআপ':'Sign Up',
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      error_msg!=''?Text(
                        error_msg,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                        //textAlign: TextAlign.justify,
                        softWrap: true,
                      ):SizedBox.shrink(),
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
