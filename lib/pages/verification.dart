import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/database.dart';

class Verification extends StatefulWidget {
  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  Map args = {};
  final verifycodeController = TextEditingController();
  final auth = FirebaseAuth.instance;
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
                    controller: verifycodeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: args['bangla']?'যাচাইকরণ কোড':'Verification Code',
                      filled: true,
                      fillColor: Color(0xFFD2ECF2),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
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
                    onPressed: () async{
                      final credential = PhoneAuthProvider.credential(
                          verificationId: args['verificationId'],
                          smsCode: verifycodeController.text,
                      );
                      try{
                        UserCredential result = await auth.signInWithCredential(credential);
                        User? user = result.user;
                        if(user!=null && args['from']=='signup') {
                          final DatabaseService databaseservice = DatabaseService(uid: user.uid);
                          print('hi');
                          await databaseservice.updateUserData(args['name'], args['phone'], args['pass']);
                          print('hi2');
                        }
                        else if(user!=null && args['from']=='login'){
                          await FirebaseFirestore.instance.collection('uid_phone_pairs').doc(args['old_uid']).delete();
                          await FirebaseFirestore.instance.collection('uid_phone_pairs').doc(user.uid).set({
                            'phone': args['phone'],
                          });
                          await FirebaseFirestore.instance.collection('users').doc(args['phone']).update({
                            'uid': user.uid,
                          });
                        }
                        else {
                          //error
                        }
                        Navigator.pushReplacementNamed(context, '/main_menu', arguments: {
                          'bangla': args['bangla'],
                        });
                      }
                      catch(e){
                        print('here = $e');
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0,10,0,5),
                      child: Text(
                        args['bangla']?'যাচাই':'Verify',
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
