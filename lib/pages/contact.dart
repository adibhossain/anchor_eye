import 'package:flutter/material.dart';
import 'navbar.dart';

class contact extends StatefulWidget {
  @override
  _contactState createState() => _contactState();
}

class _contactState extends State<contact> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); //this
  Map args = {};
  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      backgroundColor: Color(0xFFB9E6FA),
      appBar: AppBar(
        backgroundColor: Color(0xFF186B9A),
        centerTitle: true,
        title: Text(
          args['bangla']?'যোগাযোগ করুন':'Contact Us',
          style: TextStyle(
            fontSize: 27,
            color: Color(0xFFB9E6FA),
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
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //SizedBox(height: 60),
              SizedBox(height: 50),
              // SizedBox(height: 1),
              SizedBox(
                width: 300,
                child: Text(
                  args['bangla']?'ইমেইল: anchoreye_bdasia@gmail.com':'Email: anchoreye_bdasia@gmail.com',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 300,
                child: Text(
                  args['bangla']?'ফোন: ০১৭০৩০৬১৫৩৩':'Phone: 01703061533',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30),
              // children:
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //SizedBox(width: 3),
                IconButton(
                  icon: Image.asset('assets/fb.png'),
                  iconSize: 100,
                  onPressed: () {},
                ),
                    SizedBox(width: 1),
                IconButton(
                  icon: Image.asset('assets/wa.png'),
                  iconSize: 100,
                  onPressed: () {},
                ),
                    SizedBox(width: 1),
                IconButton(
                  icon: Image.asset('assets/ig.png'),
                  iconSize: 100,
                  onPressed: () {},
                ),

                    //SizedBox(width: 1),

                  ]
              ),
              // GFIconButton(
              //   onPressed: (){},
              //   icon: Icon(Icons.facebook),
              // ),
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
    );
  }
}
