import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import 'navbar.dart';

class Your_fishfarm extends  StatefulWidget {
  Farmer? user = null;
  @override
  _YourFishFarm createState() => _YourFishFarm();
}

class _YourFishFarm extends State<Your_fishfarm>{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); //this
  Map args = {};
  @override
  Widget build(BuildContext context) {
    widget.user = Provider.of<Farmer?>(context);
    //print(widget.user?.name);
    args = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      backgroundColor: Color(0xFF99CDE3),
      appBar: AppBar(
        backgroundColor: Color(0xFF186B9A),
        centerTitle: true,
        title: Text(
          args['bangla']?'আপনার খামারসমূহ':'Your Farms',
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
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage('assets/main_icon.png'),
                height: 150.0,
                width: 150.0,
              ),
              SizedBox(height:45),
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    minimumSize: const Size(200, 30),
                    foregroundColor: Color(0xFF0A457C),
                    backgroundColor: Color(0xFFD2ECF2),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/specific_farm', arguments: {
                      'bangla': args['bangla'],
                      'farm_name': args['bangla']?'রুই খামার':'Rui Farm',
                      'species': args['bangla']?'রুই':'Rui',
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0,20,0,15),
                    child: Text(
                      args['bangla']?'রুই খামার':'Rui Farm',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    minimumSize: const Size(200, 30),
                    foregroundColor: Color(0xFF0A457C),
                    backgroundColor: Color(0xFFD2ECF2),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/specific_farm', arguments: {
                      'bangla': args['bangla'],
                      'farm_name': args['bangla']?'পাঙ্গাশ খামার':'Pangash Farm',
                      'species': args['bangla']?'পাঙ্গাশ':'Pangash',
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0,20,0,15),
                    child: Text(
                      args['bangla']?'পাঙ্গাশ খামার':'Pangash Farm',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    minimumSize: const Size(170, 30),
                    foregroundColor: Color(0xFFD2ECF2),
                    backgroundColor: Color(0xFF186B9A),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/add_farm', arguments: {
                      'bangla': args['bangla'],
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0,10,0,5),
                    child: Text(
                      args['bangla']?'খামার যোগ করুন':'Add Farm',
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

