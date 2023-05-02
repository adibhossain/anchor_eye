import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../services/auth.dart';
import 'navbar.dart';

class MainMenu extends StatefulWidget {
  Farmer? user = null;
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); //this
  Map args = {};
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    widget.user = Provider.of<Farmer?>(context);
    widget.user?.setOtherData();
    args = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      backgroundColor: Color(0xFFB9E6FA),
      appBar: AppBar( //this
        backgroundColor: Color(0xFF186B9A),
        centerTitle: true,
        title: Text(
          args['bangla']?'অ্যাংকর আই':'Anchor Eye',
          style: TextStyle(
            fontSize: 30.0,
            color: Color(0xFFD2ECF2),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      key: _scaffoldKey, //this
      drawer: NavBar(bangla: args['bangla'],index: 0), //this
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
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    minimumSize: const Size(200, 30),
                    foregroundColor: Color(0xFF0A457C),
                    backgroundColor: Color(0xFFD2ECF2),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/yourfishfarms', arguments: {
                      'bangla': args['bangla'],
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0,10,0,5),
                    child: Text(
                      args['bangla']?'খামারসমূহ':'Your Farms',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    minimumSize: const Size(200, 30),
                    foregroundColor: Color(0xFF0A457C),
                    backgroundColor: Color(0xFFD2ECF2),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/helpninfo', arguments: {
                      'bangla': args['bangla'],
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0,10,0,5),
                    child: Text(
                      args['bangla']?'তথ্য ও সেবা':'Help & Info',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    minimumSize: const Size(200, 30),
                    foregroundColor: Color(0xFF0A457C),
                    backgroundColor: Color(0xFFD2ECF2),
                  ),
                  onPressed: () async{
                    await _auth.signOut();
                    Navigator.pushReplacementNamed(context, '/', arguments: {
                      'bangla': args['bangla'],
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0,10,0,5),
                    child: Text(
                      args['bangla']?'সাইন আউট':'Sign Out',
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
    );
  }
}
