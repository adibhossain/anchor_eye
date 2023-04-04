import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'navbar.dart';

class Used_Fertilizer extends StatefulWidget {
  @override
  _Used_FertilizerState createState() => _Used_FertilizerState();
}

class _Used_FertilizerState extends State<Used_Fertilizer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); //this
  Map args = {};
  var fertilizer_cnt=0;
  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      backgroundColor: Color(0xFF99CDE3),
      appBar: AppBar(
        backgroundColor: Color(0xFF186B9A),
        centerTitle: true,
        title: Text(
          args['bangla']?'খামার আপডেট করুন':'Update Farm',
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
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: args['bangla']?'প্রয়োগকৃত সারের ধরণের সংখ্যা':'Used Number of Fertilizer Types',
                      filled: true,
                      fillColor: Color(0xFFD2ECF2),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onSubmitted: (val){
                      fertilizer_cnt = int.parse(val);
                      setState(() {});
                      //debugPrint(int.parse(val).toString());
                    },
                  ),
                ),
                SizedBox(
                  height: fertilizer_cnt<=3?(fertilizer_cnt*70):210,
                  child: ListView.builder(
                    itemCount: fertilizer_cnt,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 185,
                            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: args['bangla']?'সারের নাম':'Fertilizer Name',
                                filled: true,
                                fillColor: Color(0xFFD2ECF2),
                              ),
                            ),
                          ),
                          Container(
                            width: 185,
                            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: args['bangla']?'পরিমাণ(গ্রাম)':'Amount(gm)',
                                filled: true,
                                fillColor: Color(0xFFD2ECF2),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 25),
                Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      minimumSize: const Size(170, 30),
                      foregroundColor: Color(0xFFD2ECF2),
                      backgroundColor: Color(0xFF186B9A),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/update_farm', arguments: {
                        'bangla': args['bangla'],
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0,10,0,5),
                      child: Text(
                        args['bangla']?'আপডেট করুন':'Update',
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
