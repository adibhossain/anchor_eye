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
  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Navigator.pushNamed(context,'/manual2');
          i++; i%=2;
          //debugPrint(i.toString());
          setState(() {});
        },
        child: Image(
          image: AssetImage('assets/next'+i.toString()+'.png'),
        ),
        backgroundColor: Colors.white,
      ),
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
      drawer: NavBar(bangla: args['bangla'], index: 1), //this
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //SizedBox(height: 60),
                SizedBox(height: 20),
                // SizedBox(height: 1),
                Image(
                  image: AssetImage('assets/m'+(args['bangla']?1:0).toString()+i.toString()+'.JPG'),
                  height: 570.0,
                  width: 570.0,
                ),
                // height:150,
                // width:100,
                // SizedBox(height: 0),

                // Container(
                //   child: Text(
                //     '',
                //     style: TextStyle(
                //       fontSize: 25.0,
                //       color: Color(0xFF0A457C),
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                // Container(
                //   // child: SpinKitRing(
                //   //   color: Color(0xFF0A457C),
                //   //   size: 50.0,
                //   // ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
