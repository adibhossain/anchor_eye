import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForgotPass extends StatefulWidget {
  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  bool loading = false, submitted=false;
  String error_msg='';
  Map args = {};
  final auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final otherinfoController = TextEditingController();
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
                submitted?
                Column(
                  children: [
                    SizedBox(height: 40),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 3),
                      child: Text(
                        args['bangla']?'আপনার অনুরোধ রেকর্ড করা হয়েছে। আমরা শীঘ্রই আপনার কাছে প্রতিক্রিয়া জানাব।'
                            :'Your request has been recorded. We will get back to you shortly',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF186B9A),
                        ),
                        textAlign: TextAlign.center,
                        //textAlign: TextAlign.justify,
                        softWrap: true,
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
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/home', arguments: {
                            'bangla': true,
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0,10,0,5),
                          child: loading?SpinKitRing(
                            color: Color(0xFFD2ECF2),
                            size: 30.0,
                          )
                              :Text(
                            args['bangla']?'ঠিক আছে':'Okay',
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ) :
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
                          maxLines: 3,
                          controller: otherinfoController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: args['bangla']?'আপনার অ্যাকাউন্ট সম্পর্কে আমাদের আরও বলুন (ঐচ্ছিক)':'Tell us more about your account (optional)',
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
                            if(nameController.text=='' || phoneController.text==''){
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
                            bool not_reg=false;
                            await FirebaseFirestore.instance.collection('users').doc(phoneno).get().then((documentSnapshot) async {
                              if (!documentSnapshot.exists){
                                //print('Please register first');
                                error_msg=(args['bangla']?'এই নম্বর নিবন্ধিত নয়':'This number is not registered');
                                not_reg=true;
                              }
                            }).catchError((error){
                              print('Error retrieving document: $error');
                            });
                            if(not_reg){
                              loading=false;
                              setState(() {});
                              return;
                            }
                            var otherinfo=(otherinfoController.text.length==0?'':otherinfoController.text);
                            int entry_cnt=0;
                            await FirebaseFirestore.instance.collection('forgot_pass').doc('entry_cnt').get().then((docsnap2) async{
                              entry_cnt = await docsnap2.get('cnt');
                            });
                            await FirebaseFirestore.instance.collection('forgot_pass').doc(entry_cnt.toString()).set({
                              'name': nameController.text,
                              'phone': phoneno,
                              'otherinfo': otherinfo,
                            });
                            entry_cnt=entry_cnt+1;
                            await FirebaseFirestore.instance.collection('forgot_pass').doc('entry_cnt').set({
                              'cnt': entry_cnt,
                            });
                            loading=false;
                            setState(() {});
                            submitted=true;
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
