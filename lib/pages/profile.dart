import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import 'navbar.dart';

class Profile extends StatefulWidget {
  Farmer? user = null;
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); //this
  Map args = {};
  @override
  Widget build(BuildContext context) {
    widget.user = Provider.of<Farmer?>(context);
    args = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      backgroundColor: Color(0xFFB9E6FA),
      appBar: AppBar( //this
        backgroundColor: Color(0xFF186B9A),
        centerTitle: true,
        title: Text(
          args['bangla']?'প্রোফাইল':'Profile',
          style: TextStyle(
            fontSize: 30.0,
            color: Color(0xFFD2ECF2),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      key: _scaffoldKey, //this
      drawer: NavBar(bangla: args['bangla'],index: 1), //this
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage('assets/main_icon.png'),
                height: 110.0,
                width: 110.0,
              ),
              SizedBox(height: 60),
              Container(
                child: Text(
                  (args['bangla']?'নাম: ':'Name: ')+(widget.user==null?'মৎস্যবিষয়ক_রাশিদ':widget.user!.name),
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Color(0xFF0A457C),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                child: Text(
                  (args['bangla']?'মোবাইল নম্বর: ':'Mobile No: ')+(widget.user==null?'০১৭৬৫২৭৯০২৬':widget.user!.phone),
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Color(0xFF0A457C),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
