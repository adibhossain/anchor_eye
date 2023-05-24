import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert' as convert;

class ControlPanel extends StatefulWidget {
  @override
  _ControlPanelState createState() => _ControlPanelState();
}

class _ControlPanelState extends State<ControlPanel> {
  Map args = {};
  bool hints=false;
  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      backgroundColor: Color(0xFFB9E6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Image.asset('assets/refresh.png'),
                    iconSize: 20,
                    onPressed: () {},
                  ),
                  SizedBox(width: 230),
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
              Image(
                image: AssetImage('assets/livefeed.png'),
                height: 200.0,
                width: 300.0,
              ),
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
                          DateTime selectedDate = DateTime.now();
                          print('hello from flutter');

                          var url = Uri.parse('http://192.168.43.139:5000/api/hello?p1=1&p2=2');

                          try{
                            var response = await http.get(url);
                            print('Response body: ${response.body}');
                            var jsonResponse = convert.jsonDecode(response.body);
                            await args['farm_data'].reference.collection('params').doc("${selectedDate.toLocal()}".split(' ')[0]).set({
                              'DO':'8.0',
                              'nitrate':'180',
                              'fish_length':'7.5',
                              'fish_weight':'2.1',
                              'month':'May',
                              'season':'Summer',
                              'pH':jsonResponse['ph'],
                              'temperature':jsonResponse['temp'],
                              'turbidity':jsonResponse['turb'],
                              'n':jsonResponse['n'],
                            });
                          }catch(e){
                            print(e);
                          }
                          //print('Response status: ${response.statusCode}');

                          //print('The sum of ${jsonResponse['a']} and ${jsonResponse['b']} is ${jsonResponse['sum']}.');
                          //Navigator.pop(context);
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
                    icon: Image.asset('assets/full-screen-icon.png'),
                    iconSize: 20,
                    onPressed: () {
                      Navigator.pushNamed(context, '/control_panel_full', arguments: {
                        'bangla': args['bangla'],
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              IconButton(
                                icon: Image.asset('assets/rotate-left.png'),
                                iconSize: 20,
                                onPressed: () {},
                              ),
                              hints?Text(
                                args['bangla']?'ঘড়ির কাঁটার\nবিপরীতে':'Anti-clockwise',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ):SizedBox.shrink(),
                            ],
                          ),
                          SizedBox(width: 15),
                          Column(
                            children: [
                              IconButton(
                                icon: Image.asset('assets/rotate-right.png'),
                                iconSize: 20,
                                onPressed: () {},
                              ),
                              hints?Text(
                                args['bangla']?'ঘড়ির কাঁটার\nদিকে':'Clockwise',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ):SizedBox.shrink(),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      hints?Text(
                        args['bangla']?'ক্যামেরা ঘোরান':'Rotate Camera',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ):SizedBox.shrink(),
                    ],
                  ),
                  SizedBox(width: 80),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        args['bangla']?'উপর':'Up',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Image.asset('assets/rod.png'),
                        iconSize: 70,
                        onPressed: () {},
                      ),
                      Text(
                        args['bangla']?'নিচে':'Down',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      hints?Text(
                        args['bangla']?'ক্যামেরা গভীরতা':'Camera Depth',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ):SizedBox.shrink(),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      IconButton(
                        icon: Image.asset('assets/up.png'),
                        iconSize: 40,
                        onPressed: () async{
                          print('wanna control u');

                          var url = Uri.parse('http://192.168.43.139:5000/api/control?p1=1&p2=2');

                          try{
                            var response = await http.get(url);
                            print('Response body: ${response.body}');
                            //var jsonResponse = convert.jsonDecode(response.body);

                          }catch(e){
                            print(e);
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            icon: Image.asset('assets/left.png'),
                            iconSize: 40,
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Image.asset('assets/stop.png'),
                            iconSize: 40,
                            onPressed: () async{
                              print('wanna control u');

                              var url = Uri.parse('http://192.168.43.139:5000/api/control?p1=0&p2=2');

                              try{
                                var response = await http.get(url);
                                print('Response body: ${response.body}');
                                //var jsonResponse = convert.jsonDecode(response.body);

                              }catch(e){
                                print(e);
                              }
                            },
                          ),
                          IconButton(
                            icon: Image.asset('assets/right.png'),
                            iconSize: 40,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Image.asset('assets/down.png'),
                        iconSize: 40,
                        onPressed: () {},
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
            ],
          ),
        ),
      ),
    );
  }
}
