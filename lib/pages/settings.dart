import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import 'navbar.dart';

class settings extends StatefulWidget {
  Farmer? user = null;
  @override
  _settingsState createState() => _settingsState();
}

class _settingsState extends State<settings> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); //this
  Map args = {};
  @override
  Widget build(BuildContext context) {
    widget.user = Provider.of<Farmer?>(context);
    args = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      backgroundColor: Color(0xFFB9E6FA),
      appBar: AppBar(
        backgroundColor: Color(0xFF186B9A),
        centerTitle: true,
        title: Text(
          args['bangla']?'সেটিংস':'Settings',
          style: TextStyle(
            fontSize: 30.0,
            color: Color(0xFFD2ECF2),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      key: _scaffoldKey, //this
      drawer: NavBar(bangla: args['bangla'], index: 3), //this
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/sett.JPG'),
                SizedBox(height:5),
                Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      minimumSize: const Size(200, 80),
                      foregroundColor: Color(0xFF0A457C),
                      backgroundColor: Color(0xFFD2ECF2),
                    ),
                    onPressed: args['bangla']? null : () async {
                      args['bangla'] = true;
                      await FirebaseFirestore.instance.collection('users').doc(widget.user?.phone).update({
                        'bangla':true,
                      });
                      setState(() {});
                    },

                    child: Container(
                      padding: EdgeInsets.fromLTRB(0,10,0,5),
                      child: Text(
                        'বাংলা',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      minimumSize: const Size(200, 80),
                      foregroundColor: Color(0xFF0A457C),
                      backgroundColor: Color(0xFFD2ECF2),
                    ),
                    onPressed: !args['bangla']? null : () async{
                      args['bangla'] = false;
                      await FirebaseFirestore.instance.collection('users').doc(widget.user?.phone).update({
                        'bangla':false,
                      });
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0,10,0,5),
                      child: Text(
                        'English',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  height: 50,
                  thickness: 1,
                  indent: 60,
                  endIndent: 60,
                  color: Color(0xFF0A457C),
                ),
                Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      minimumSize: const Size(200, 80),
                      foregroundColor: Color(0xFF0A457C),
                      backgroundColor: Color(0xFFD2ECF2),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/configure_pi', arguments: {
                        'bangla': args['bangla'],
                        'farm_data': null,
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0,10,0,5),
                      child: Text(
                        args['bangla']?'কনফিগার Pi':'Configure Pi',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      minimumSize: const Size(200, 80),
                      foregroundColor: Color(0xFF0A457C),
                      backgroundColor: Color(0xFFD2ECF2),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/pass_barrier', arguments: {
                        'bangla': args['bangla'],
                        'goto': '/new_pass',
                        'gototo': '/settings',
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0,10,0,5),
                      child: Text(
                        args['bangla']?'পাসওয়ার্ড পরিবর্তন':'Change Password',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      minimumSize: const Size(200, 80),
                      foregroundColor: Color(0xFF0A457C),
                      backgroundColor: Color(0xFFD2ECF2),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/pass_barrier', arguments: {
                        'bangla': args['bangla'],
                        'goto': '/mobile_no',
                        'gototo': '/verification',
                        'gotototo': '/settings',
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0,10,0,5),
                      child: Text(
                        args['bangla']?'ফোন নম্বর পরিবর্তন':'Change Phone No.',
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
