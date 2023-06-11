import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/user.dart';
import 'navbar.dart';

class Connect_Pi extends StatefulWidget {
  Farmer? user = null;
  @override
  _Connect_PiState createState() => _Connect_PiState();
}

class _Connect_PiState extends State<Connect_Pi> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); //this
  Map args = {};
  var pi_ip = '';
  bool loading = false, failed=false;
  @override
  Widget build(BuildContext context) {
    widget.user = Provider.of<Farmer?>(context);
    pi_ip = widget.user!.pi_ip;
    //pi_ip = '192.168.1.105';
    args = ModalRoute.of(context)?.settings.arguments as Map;
    failed = args['failed'];
    return Scaffold(
      backgroundColor: Color(0xFFB9E6FA),
      appBar: AppBar(
        backgroundColor: Color(0xFF186B9A),
        centerTitle: true,
        title: Text(
          args['bangla']?"আপনার Pi সংযোগ করুন":"Connect your Pi",
          style: TextStyle(
            fontSize: 30.0,
            color: Color(0xFFD2ECF2),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      key: _scaffoldKey, //this
      drawer: NavBar(bangla: args['bangla']), //this
      body: Center(
        child: SingleChildScrollView(
          child: pi_ip.length>0?Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage('assets/hotspot.png'),
                height: 150.0,
                width: 150.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40,vertical: 40),
                child: Text(
                  args['bangla']?'সিস্টেমের সাথে সংযোগ করতে নিম্নলিখিতগুলি করুন:\n\n\t1) আপনার মোবাইল হটস্পট চালু করুন।\n\n\t2) রোবট বডি চালু করুন।\n\n\t3) সংযোগ বোতামে চাপুন।'
                      :'To connect to the system do the following in order:\n\n\t1) Turn on your mobile hotspot.\n\n\t2) Turn on the robot body.\n\n\t3) Tap on the connect button.',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF186B9A),
                  ),
                  //textAlign: TextAlign.justify,
                  softWrap: true,
                ),
              ),
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    minimumSize: const Size(200, 70),
                    maximumSize: const Size(200, 70),
                    foregroundColor: Color(0xFF0A457C),
                    backgroundColor: Color(0xFFD2ECF2),
                  ),
                  onPressed: () async{
                    /*Navigator.pushNamed(context, '/control_panel', arguments: {
                      'bangla': args['bangla'],
                      'farm_data': args['farm_data'],
                      'pi_ip': 'http://'+pi_ip,
                    });
                    return;*/
                    if(loading) return;
                    loading = true;
                    setState(() {});
                    var url = Uri.parse('http://'+pi_ip+':5000/api/connect');
                    try{
                      var response = await http.get(url).timeout(Duration(seconds: 5)); // .timeout(Duration(seconds: 10))
                      //print('Response body: ${response.body}');
                      Navigator.pushNamed(context, '/control_panel', arguments: {
                        'bangla': args['bangla'],
                        'farm_data': args['farm_data'],
                        'pi_ip': 'http://'+pi_ip,
                      });
                    }catch(e){
                      args['failed']=true;
                      setState(() {});
                      print(e);
                    }
                    loading=false;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0,10,0,5),
                    child: loading?SpinKitRing(
                      color: Color(0xFF186B9A),
                      size: 30.0,
                    )
                        :Text(
                      args['bangla']?'সংযোগ':'Connect',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                child: Row(
                  children: [
                    Flexible(
                        child: Text.rich(
                          TextSpan(
                            text: args['bangla']?'আপনার সিস্টেমের আইপি ঠিকানা পরিবর্তন করা হলে দয়া করে '
                                :'If the ip address of your system has changed please ',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.normal,
                              color: Color(0xFF186B9A),
                            ),
                            children: <InlineSpan>[
                              TextSpan(
                                text: args['bangla']?'পুনরায় কনফিগার করুন':'reconfigure',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, '/configure_pi', arguments: {
                                      'bangla': args['bangla'],
                                      'farm_data': args['farm_data'],
                                    });
                                  },
                              ),
                            ],
                          )
                        )
                    ),
                  ],
                ),
              ),
              failed?Text(
                args['bangla']?'সংযোগ করা যায়নি'
                    :'Could not connect',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
                //textAlign: TextAlign.justify,
                softWrap: true,
              ):SizedBox.shrink(),
            ],
          )
              :Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage('assets/hotspot.png'),
                height: 150.0,
                width: 150.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40,vertical: 40),
                child: Text(
                  args['bangla']?'আপনার সিস্টেমের আইপি ঠিকানা এখনও কনফিগার করা হয়নি। অনুগ্রহ করে নিশ্চিত করুন যে এটি একজন প্রশাসকের সাহায্যে আপনার মোবাইল হটস্পটের সাথে সংযোগ করার জন্য কনফিগার করা হয়েছে৷'
                      :'The IP address of your system is not configured yet. Please ensure that it is configured to connect to your mobile hotspot with the help of an admin.',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF186B9A),
                  ),
                  //textAlign: TextAlign.justify,
                  softWrap: true,
                ),
              ),
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    minimumSize: const Size(200, 70),
                    maximumSize: const Size(200, 70),
                    foregroundColor: Color(0xFF0A457C),
                    backgroundColor: Color(0xFFD2ECF2),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/configure_pi', arguments: {
                      'bangla': args['bangla'],
                      'farm_data': args['farm_data'],
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0,10,0,5),
                    child: Text(
                      args['bangla']?'কনফিগার':'Configure',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              failed?Text(
                args['bangla']?'সংযোগ করা যায়নি'
                    :'Could not connect',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
                //textAlign: TextAlign.justify,
                softWrap: true,
              ):SizedBox.shrink(),
            ],
          )
        ),
      ),
    );
  }
}
