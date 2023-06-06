import 'dart:ui';
import 'package:bcrypt/bcrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import 'navbar.dart';

class Configure_Pi extends StatefulWidget {
  Farmer? user = null;
  @override
  _Configure_PiState createState() => _Configure_PiState();
}

class _Configure_PiState extends State<Configure_Pi> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); //this
  bool loading = false;
  String error_msg='';
  Map args = {};
  final pi_ip = TextEditingController();
  final admin_pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    widget.user = Provider.of<Farmer?>(context);
    args = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      backgroundColor: Color(0xFF99CDE3),
      appBar: AppBar(
        backgroundColor: Color(0xFF186B9A),
        centerTitle: true,
        title: Text(
          args['bangla']?'কনফিগার Pi':'Configure Pi',
          style: TextStyle(
            fontSize: 30.0,
            color: Color(0xFFD2ECF2),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      key: _scaffoldKey, //this
      drawer: NavBar(bangla: args['bangla']), //this
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 65, vertical: 5),
                  child: TextFormField(
                    controller: pi_ip,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: args['bangla']?'Pi এর আইপি ঠিকানা':'IP Address of Pi',
                      filled: true,
                      fillColor: Color(0xFFD2ECF2),
                    ),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 65, vertical: 5),
                  child: TextFormField(
                    obscureText: true,
                    controller: admin_pass,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: args['bangla']?"অ্যাডমিনের পাসওয়ার্ড":"Admin's Password",
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
                SizedBox(height: 25),
                Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      minimumSize: const Size(170, 30),
                      maximumSize: const Size(230, 50),
                      foregroundColor: Color(0xFFD2ECF2),
                      backgroundColor: Color(0xFF186B9A),
                    ),
                    onPressed: () async{
                      if(loading) return;
                      loading=true;
                      setState(() {});
                      if(pi_ip.text=='' || admin_pass.text==''){
                        error_msg=(args['bangla']?'ফর্ম পূরণ করুন':'Please fill up the form');
                        loading=false;
                        setState(() {});
                        return;
                      }
                      var ips = pi_ip.text.split('.');
                      bool ip_ok=true;
                      if(ips.length!=4) ip_ok=false;
                      else if(ips[0].length>3 || ips[1].length>3 || ips[2].length>3 || ips[3].length>3) ip_ok=false;
                      if(!ip_ok){
                        error_msg=(args['bangla']?'অবৈধ আইপি ঠিকানা':'Invalid IP Address');
                        loading=false;
                        setState(() {});
                        return;
                      }
                      String hashedpass = '\$2a\$10\$9jcEn1XnMbrdEZMAExS1Kuw2tD5sqRxTnR8.ykfww5WFECqa78yoa';
                      bool ok = BCrypt.checkpw(admin_pass.text, hashedpass);
                      if(ok){
                        error_msg='';
                        await FirebaseFirestore.instance.collection('users').doc(widget.user?.phone).update({
                          'pi_ip': pi_ip.text,
                        });
                        widget.user?.pi_ip=pi_ip.text;
                        print(widget.user?.pi_ip);
                        loading=false;
                        setState(() {});
                        if(args['farm_data']!=null){
                          Navigator.pushNamed(context, '/connect_pi', arguments: {
                            'bangla': args['bangla'],
                            'farm_data': args['farm_data'],
                            'failed': false,
                          });
                        }
                        else {
                          Navigator.pushReplacementNamed(context, '/main_menu', arguments: {
                            'bangla': args['bangla'],
                          });
                        }
                      }
                      else {
                        error_msg=(args['bangla']?'ভুল পাসওয়ার্ড':'Incorrect password');
                      }
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
                        args['bangla']?'আপডেট করুন':'Update',
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
