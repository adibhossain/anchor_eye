import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  var farmlist;

  Future loadFarms() async {
    return await FirebaseFirestore.instance
        .collection('farms')
        .doc(widget.user?.phone)
        .collection('specific_farms')
        .get().then((docsnap){
      farmlist = docsnap.docs;
      //print(farmlist);
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.user = Provider.of<Farmer?>(context);
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
              SizedBox(height:30),
              SizedBox(
                height: 200,
                width: 210,
                child: FutureBuilder(
                  future: loadFarms(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.done){
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: farmlist==null?0:farmlist.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
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
                                  'farm_data': farmlist[index],
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.fromLTRB(0,20,0,15),
                                child: Text(
                                  farmlist==null?'Rui Farm':farmlist[index].id,
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    else{
                      return Container(
                        child: SpinKitRing(
                          color: Color(0xFF0A457C),
                          size: 50.0,
                        ),
                      );
                    }
                  },
                )
              ),
              //SizedBox(height: 30),
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

