import 'package:bcrypt/bcrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class New_Pass extends StatefulWidget {
  @override
  _New_PassState createState() => _New_PassState();
}

class _New_PassState extends State<New_Pass> {
  Map args = {};
  final oldpass = TextEditingController();
  final newpass = TextEditingController();
  final newpassconfirm = TextEditingController();
  bool loading = false;
  String error_msg='';
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
                  child: TextFormField(
                    obscureText: true,
                    controller: oldpass,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: args['bangla']?'বর্তমান পাসওয়ার্ড':'Current Password',
                      filled: true,
                      fillColor: Color(0xFFD2ECF2),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 8),
                  child: TextFormField(
                    obscureText: true,
                    controller: newpass,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: args['bangla']?'নতুন পাসওয়ার্ড':'New Password',
                      filled: true,
                      fillColor: Color(0xFFD2ECF2),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 8),
                  child: TextFormField(
                    obscureText: true,
                    controller: newpassconfirm,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: args['bangla']?'পাসওয়ার্ড নিশ্চিত করুন':'Confirm Password',
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
                      maximumSize: const Size(210, 50),
                      foregroundColor: Color(0xFFD2ECF2),
                      backgroundColor: Color(0xFF186B9A),
                    ),
                    onPressed: () async{
                      if(loading) return;
                      loading = true;
                      setState(() {});
                      if(oldpass.text=='' || newpass.text=='' || newpassconfirm.text==''){
                        error_msg=(args['bangla']?'ফর্ম পূরণ করুন':'Please fill up the form');
                        loading=false;
                        setState(() {});
                        return;
                      }
                      if(newpass.text != newpassconfirm.text){
                        error_msg=(args['bangla']?"পাসওয়ার্ড মিলছে না":"Passwords do not match");
                        loading=false;
                        setState(() {});
                        return;
                      }
                      await FirebaseFirestore.instance.collection('users').doc(args['phone']).get().then((documentSnapshot) async {
                        bool ok = false;
                        String hashedpass =  documentSnapshot.get('pass');
                        //print(hashedpass);
                        ok = BCrypt.checkpw(oldpass.text, hashedpass);
                        //print('here');
                        if(ok) {
                          error_msg='';
                          final salt = await BCrypt.gensalt();
                          final hashpass = await BCrypt.hashpw(newpass.text, salt);
                          await FirebaseFirestore.instance.collection('users').doc(args['phone']).update({
                            'pass': hashpass,
                          });
                          loading = false;
                          setState(() {});
                          Navigator.pushReplacementNamed(context, '/settings', arguments: {
                            'bangla': args['bangla'],
                          });
                        }
                        else {
                          error_msg=(args['bangla']?'ভুল পাসওয়ার্ড':'Incorrect password');
                        }
                      }).catchError((error){
                        print('Error retrieving document: $error');
                      });
                      loading = false;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0,10,0,5),
                      child: loading?SpinKitRing(
                        color: Color(0xFFD2ECF2),
                        size: 30.0,
                      )
                          :Text(
                        args['bangla']?'জমা দিন':'Submit',
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
        ),
      ),
    );
  }
}
