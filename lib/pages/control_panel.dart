import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert' as convert;

import 'navbar.dart';

class ControlPanel extends StatefulWidget {
  @override
  _ControlPanelState createState() => _ControlPanelState();
}

class _ControlPanelState extends State<ControlPanel> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Map args = {};
  bool hints=false, sampling=false;
  var pi_ip;
  final month_name = ['','January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
  final season = ['','Winter', 'Winter', 'Summer', 'Summer', 'Summer', 'Rainy', 'Rainy', 'Rainy', 'Rainy', 'Rainy', 'Winter', 'Winter'];
  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)?.settings.arguments as Map;
    pi_ip = args['pi_ip'];
    return Scaffold(
      backgroundColor: Color(0xFFB9E6FA),
      appBar: AppBar( //this
        backgroundColor: Color(0xFF186B9A),
        centerTitle: true,
        title: Text(
          args['bangla']?'কন্ট্রল প্যানেল':'Control Panel',
          style: TextStyle(
            fontSize: 30.0,
            color: Color(0xFFD2ECF2),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      key: _scaffoldKey, //this
      drawer: NavBar(bangla: args['bangla'], index: -1),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/battery-icon.png'),
                      height: 50,
                      width: 50,
                    ),
                    Text(
                      args['bangla']?'৯৫%':'95%',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Image.asset('assets/power-off.png'),
                      iconSize: 40,
                      onPressed: () async{
                        sampling=true;
                        setState(() {});
                        DateTime selectedDate = DateTime.now();
                        print('hello from flutter');

                        // Send request to shutdown motors first then do the following

                        var url = Uri.parse(pi_ip+':5000/api/hello?p1=5');

                        try{
                          var response = await http.get(url);
                          // if response.statuscode == 200 else
                          print('Response body: ${response.body}');
                          var jsonResponse = convert.jsonDecode(response.body);
                          var month = int.parse("${selectedDate.toLocal()}".split(' ')[0].split('-')[1]);
                          await args['farm_data'].reference.collection('params').doc("${selectedDate.toLocal()}".split(' ')[0]).set({
                            'DO':'8.0',
                            'nitrate':'180',
                            'fish_length':'7.5',
                            'fish_weight':'2.1',
                            'month':month_name[month],
                            'season':season[month],
                            'pH':jsonResponse['ph'],
                            'temperature':jsonResponse['temp'],
                            'turbidity':jsonResponse['turb'],
                            'n':jsonResponse['n'],
                          });
                        }catch(e){
                          print(e);
                        }
                        //print('Response status: ${response.statusCode}');

                        sampling=false;
                        setState(() {});

                        // Navigator.pushNamed(context, '/specific_farm', arguments: {
                        //   'bangla': args['bangla'],
                        //   'farm_data': args['farm_data'],
                        // });
                      },
                    ),
                    hints?Text(
                      args['bangla']?'সিস্টেম থামান':'Stop System',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ):SizedBox.shrink(),
                  ],
                ),
                IconButton(
                  icon: Image.asset('assets/help.png'),
                  iconSize: 20,
                  onPressed: () {
                    hints=true;
                    setState(() {});
                    Future.delayed(Duration(seconds: 5), () {
                      hints=false;
                      setState(() {});
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: [
                    IconButton(
                      icon: Image.asset('assets/sample.png'),
                      iconSize: 40,
                      onPressed: () async{
                        sampling=true;
                        setState(() {});
                        print('wanna sample u');

                        var url = Uri.parse(pi_ip+':5000/api/control?p1=s');

                        try{
                          var response = await http.get(url).timeout(Duration(seconds: 10));
                          print('Response body: ${response.body}');
                          //var jsonResponse = convert.jsonDecode(response.body);

                        }catch(e){
                          Navigator.pushNamed(context, '/connect_pi', arguments: {
                            'bangla': args['bangla'],
                            'farm_data': args['farm_data'],
                            'failed': true,
                          });
                          //print(e);
                        }
                        sampling=false;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 5),
                    hints?Text(
                      args['bangla']?'নমুনা নিন':'Take Sample',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ):SizedBox.shrink(),
                  ],
                ),
              ],
            ),
            SizedBox(height: 80),
            sampling?Container(
              padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
              child: SpinKitRing(
                color: Color(0xFF0A457C),
                size: 50.0,
              ),
            )
            :Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    IconButton(
                      icon: Image.asset('assets/up.png'),
                      iconSize: 40,
                      onPressed: () async{
                        print('wanna control u');

                        var url = Uri.parse(pi_ip+':5000/api/control?p1=1');

                        try{
                          var response = await http.get(url).timeout(Duration(seconds: 5)); // .timeout(Duration(seconds: 10))
                          print('Response body: ${response.body}');
                          //var jsonResponse = convert.jsonDecode(response.body);

                        }catch(e){
                          Navigator.pushNamed(context, '/connect_pi', arguments: {
                            'bangla': args['bangla'],
                            'farm_data': args['farm_data'],
                            'failed': true,
                          });
                          //print(e);
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: Image.asset('assets/left.png'),
                          iconSize: 40,
                          onPressed: () async{
                            print('wanna control u');

                            var url = Uri.parse(pi_ip+':5000/api/control?p1=2');

                            try{
                              var response = await http.get(url).timeout(Duration(seconds: 5));
                              print('Response body: ${response.body}');
                              //var jsonResponse = convert.jso  nDecode(response.body);

                            }catch(e){
                              Navigator.pushNamed(context, '/connect_pi', arguments: {
                                'bangla': args['bangla'],
                                'farm_data': args['farm_data'],
                                'failed': true,
                              });
                              //print(e);
                            }
                          },
                        ),
                        IconButton(
                          icon: Image.asset('assets/stop.png'),
                          iconSize: 40,
                          onPressed: () async{
                            print('wanna control u');

                            var url = Uri.parse(pi_ip+':5000/api/control?p1=0');

                            try{
                              var response = await http.get(url).timeout(Duration(seconds: 5));
                              print('Response body: ${response.body}');
                              //var jsonResponse = convert.jsonDecode(response.body);

                            }catch(e){
                              Navigator.pushNamed(context, '/connect_pi', arguments: {
                                'bangla': args['bangla'],
                                'farm_data': args['farm_data'],
                                'failed': true,
                              });
                              //print(e);
                            }
                          },
                        ),
                        IconButton(
                          icon: Image.asset('assets/right.png'),
                          iconSize: 40,
                          onPressed: () async{
                            print('wanna control u');

                            var url = Uri.parse(pi_ip+':5000/api/control?p1=3');

                            try{
                              var response = await http.get(url).timeout(Duration(seconds: 5));
                              print('Response body: ${response.body}');
                              //var jsonResponse = convert.jsonDecode(response.body);

                            }catch(e){
                              Navigator.pushNamed(context, '/connect_pi', arguments: {
                                'bangla': args['bangla'],
                                'farm_data': args['farm_data'],
                                'failed': true,
                              });
                              //print(e);
                            }
                          },
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Image.asset('assets/down.png'),
                      iconSize: 40,
                      onPressed: () async{
                        print('wanna control u');

                        var url = Uri.parse(pi_ip+':5000/api/control?p1=4');

                        try{
                          var response = await http.get(url).timeout(Duration(seconds: 5));
                          print('Response body: ${response.body}');
                          //var jsonResponse = convert.jsonDecode(response.body);

                        }catch(e){
                          Navigator.pushNamed(context, '/connect_pi', arguments: {
                            'bangla': args['bangla'],
                            'farm_data': args['farm_data'],
                            'failed': true,
                          });
                          //print(e);
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(width: 10),
                hints?Text(
                  args['bangla']?'রোবোটিক বডি মুভমেন্ট':'Robotic Body Movement',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ):SizedBox.shrink(),
              ],
            ),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
