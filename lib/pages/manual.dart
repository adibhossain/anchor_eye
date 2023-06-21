import 'package:flutter/material.dart';
import 'navbar.dart';

class Manual extends StatefulWidget {
   @override
   _ManualState createState() => _ManualState();
}

class _ManualState extends State<Manual> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); //this
  Map args = {};
  int i=0;
  final gap=20.0, font_sz=20.0;
  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      backgroundColor: Color(0xFFB9E6FA),
      appBar: AppBar(
        backgroundColor: Color(0xFF186B9A),
        centerTitle: true,
        title: Text(
          args['bangla']?'ব্যবহার বিধি':'User Manual',
          style: TextStyle(
            fontSize: 30,
            color: Color(0xFFB9E6FA),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      key: _scaffoldKey, //this
      drawer: NavBar(bangla: args['bangla'], index: 2), //this
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 2*gap),
                SizedBox(
                  width: 300,
                  child: Text(
                    args['bangla']?'':'Follow the bellow steps to get started with our app:',
                    style: TextStyle(
                      fontSize: 23.0,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                  ),
                ),
                SizedBox(height: 1.5*gap),
                SizedBox(
                  width: 300,
                  child: Text(
                    args['bangla']?'':'\t1) Navigate to: Home->Your Farms->Add Farm',
                    style: TextStyle(
                      fontSize: font_sz,
                      fontWeight: FontWeight.normal,
                    ),
                    softWrap: true,
                  ),
                ),
                SizedBox(height: gap),
                SizedBox(
                  width: 300,
                  child: Text(
                    args['bangla']?'':'\t2) Fill up the form and click add',
                    style: TextStyle(
                      fontSize: font_sz,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(height: gap),
                SizedBox(
                  width: 300,
                  child: Text(
                    args['bangla']?'':'\t3) Select the farm you just added',
                    style: TextStyle(
                      fontSize: font_sz,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(height: gap),
                SizedBox(
                  width: 300,
                  child: Text(
                    args['bangla']?'':'\t4) Go to control panel',
                    style: TextStyle(
                      fontSize: font_sz,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(height: gap),
                SizedBox(
                  width: 300,
                  child: Text(
                    args['bangla']?'':'\t5) Configure according to the instructions on that page. Then click connect',
                    style: TextStyle(
                      fontSize: font_sz,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(height: gap),
                SizedBox(
                  width: 300,
                  child: Text(
                    args['bangla']?'':'\t6) Use the robot body to collect water parameter and fish growth data',
                    style: TextStyle(
                      fontSize: font_sz,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(height: gap),
                SizedBox(
                  width: 300,
                  child: Text(
                    args['bangla']?'':'\t7) Click power off, the data will be uploaded to firebase',
                    style: TextStyle(
                      fontSize: font_sz,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(height: gap),
                SizedBox(
                  width: 300,
                  child: Text(
                    args['bangla']?'':'\t8) Go to dashboard to see the fetched data.',
                    style: TextStyle(
                      fontSize: font_sz,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(height: gap),
                SizedBox(
                  width: 300,
                  child: Text(
                    args['bangla']?'':'\t9) Overtime after many data are accumulated, you can see a graphical representation of them. You can also see which values are not ideal and see suggestions on how to improve their condition on the dashboard page',
                    style: TextStyle(
                      fontSize: font_sz,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(height: gap),
                SizedBox(
                  width: 300,
                  child: Text(
                    args['bangla']?'':'\t10) If you change daily food amount, catch some fishes from the pond or apply some fertilizers, you can add those data from the update forms in the path: Select Farm->Update Farm',
                    style: TextStyle(
                      fontSize: font_sz,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(height: gap),
                SizedBox(
                  width: 300,
                  child: Text(
                    args['bangla']?'':'\t11) You can see basic information about the farm like farm name, what fertilizers were used on which date etc. on the dashboard',
                    style: TextStyle(
                      fontSize: font_sz,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(height: gap),
                SizedBox(
                  width: 300,
                  child: Text(
                    args['bangla']?'':'For more details, please refer to the physical copy of the user manual provided during purchasing of the robot body.',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 2*gap),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
