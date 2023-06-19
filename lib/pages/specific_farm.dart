import 'package:flutter/material.dart';
import 'navbar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SpecificFarm extends StatefulWidget {
  @override
  _SpecificFarmState createState() => _SpecificFarmState();
}

class _SpecificFarmState extends State<SpecificFarm> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); //this
  Map args = {};
  bool loading=false;

  void _confirmDelete(BuildContext context) {
    var cancel = ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
        foregroundColor: Color(0xFF0A457C),
        backgroundColor: Color(0xFFD2ECF2),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(0,5,0,5),
        child: Text(
          args['bangla']?'বাতিল করুন':'Cancel',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
        confirm = ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            foregroundColor: Color(0xFFD2ECF2),
            backgroundColor: Color(0xFF186B9A),
          ),
          onPressed: () async{
            if(loading) return;
            Navigator.of(context).pop();
            loading = true;
            setState(() {});
            var docref = await args['farm_data'].reference;
            await docref.delete().then((value) async{
              print('Document deleted successfully');
              Navigator.pushNamed(context, '/yourfishfarms', arguments: {
                'bangla': args['bangla'],
              });
            }).catchError((error) {
              print('Failed to delete document: $error');
            });
            loading = false;
            setState(() {});
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(0,5,0,5),
            child: Text(
              args['bangla']?'নিশ্চিত করুন':'Confirm',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
    List<Widget> actions_list = [cancel, confirm];
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            (args['bangla']?'আপনি কি নিশ্চিত ?':'Are you sure ?'),
            style: TextStyle(
              fontSize: 30.0,
              color: Color(0xFF0A457C),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'You are about to delete the farm '+args['farm_data'].id+'.',
            style: TextStyle(
              fontSize: 20.0,
              color: Color(0xFF0A457C),
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: actions_list,
          backgroundColor: Color(0xFFB9E6FA),
          actionsPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      backgroundColor: Color(0xFFB9E6FA),
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
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    minimumSize: const Size(200, 80),
                    foregroundColor: Color(0xFF0A457C),
                    backgroundColor: Color(0xFFD2ECF2),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/dashboard', arguments: {
                      'bangla': args['bangla'],
                      'farm_data': args['farm_data'],
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0,10,0,5),
                    child: Text(
                      args['bangla']?'ড্যাশবোর্ড':'Dashboard',
                      style: TextStyle(
                        fontSize: 30.0,
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
                    minimumSize: const Size(200, 80),
                    foregroundColor: Color(0xFF0A457C),
                    backgroundColor: Color(0xFFD2ECF2),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/connect_pi', arguments: {
                      'bangla': args['bangla'],
                      'farm_data': args['farm_data'],
                      'failed': false,
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0,10,0,5),
                    child: Text(
                      args['bangla']?'কন্ট্রল প্যানেল':'Control Panel',
                      style: TextStyle(
                        fontSize: 30.0,
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
                    minimumSize: const Size(200, 80),
                    foregroundColor: Color(0xFF0A457C),
                    backgroundColor: Color(0xFFD2ECF2),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/update_farm', arguments: {
                      'bangla': args['bangla'],
                      'id': args['farm_data'].id,
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0,10,0,5),
                    child: Text(
                      args['bangla']?'খামার আপডেট':'Update Farm',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    minimumSize: const Size(200, 80),
                    maximumSize: const Size(200, 80),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red[600],
                  ),
                  onPressed: () async{
                    if(loading) return;
                    _confirmDelete(context);
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0,10,0,5),
                    child: loading?SpinKitRing(
                      color: Color(0xFFD2ECF2),
                      size: 30.0,
                    )
                        :Text(
                      args['bangla']?'খামার আপডেট':'Delete Farm',
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
