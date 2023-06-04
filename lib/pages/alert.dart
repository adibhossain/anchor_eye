import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'navbar.dart';

class Alert extends StatefulWidget {
  @override
  _AlertState createState() => _AlertState();
}

class _AlertState extends State<Alert> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); //this
  Map args = {};
  List<String> msg=[];
  int i=2;
  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)?.settings.arguments as Map;
    msg=[(args['bangla']?'১) যেহেতু শীতের মাস তাই পানির তাপমাত্রা আরও কমবে।\n২) পিএইচ আরও বাড়লে পানি মাছ চাষের অনুপযোগী হবে।\n৩) বর্তমান শুষ্ক আবহাওয়া ২ সপ্তাহ থাকবে।'
          :'1) As it is winter, water temperature will reduce more.\n2) If pH increases more, the water will be unsuitable for fish farming.\n3) Current dry weather will stay for two more weeks.'),
         (args['bangla']?'১) মাছের বৃদ্ধি কমে যেতে পারে।\n২) রুই মাছের এখনকার চেয়ে ৫০ গ্রাম বেশি খাবারের প্রয়োজন হতে পারে।\n'
          :'1) Fish growth may reduce.\n2) Rui fish will 50gm more food than current amount.')];
    i=(i==2?args['i']:i);
    return Scaffold(
      backgroundColor: Color(0xFF99CDE3),
      appBar: AppBar(
        backgroundColor: Color(0xFF186B9A),
        centerTitle: true,
        title: Text(
          args['farm_data'].id,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                args['bangla']?'ড্যাশবোর্ড - পূর্বাভাস':'Dashboard - Alerts',
                style: TextStyle(
                  fontSize: 30.0,
                  color: Color(0xFF186B9A),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    args['bangla']?'মাছের বৃদ্ধি':'Fish Growth',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: i==1?FontWeight.bold:FontWeight.normal,
                    ),
                  ),
                  IconButton(
                    icon: Image.asset('assets/slide'+i.toString()+'.png'),
                    iconSize: 40,
                    onPressed: () {
                      i++;
                      i%=2;
                      setState(() {});
                    },
                  ),
                  Text(
                    args['bangla']?'জলের গুণমান সূচক':'Water Quality Index',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: i==0?FontWeight.bold:FontWeight.normal,
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 65, vertical: 35),
              ),
              Image(
                image: AssetImage('assets/fortune.png'),
                height: 70.0,
                width: 60.0,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 65, vertical: 0),
              ),
              Container(
                child: Card(
                  color: Color(0xFFD7F1F6),
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      //debugPrint('Card tapped.');
                    },
                    child: SizedBox(
                      width: 300,
                      height: 250,
                      child: Text(msg[i]),
                    ),

                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 65, vertical: 20),
              ),

            ],
          ),


        ),
      ),
    );

  }
}
