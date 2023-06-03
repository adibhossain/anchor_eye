import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import 'navbar.dart';

class Fed_Fishes extends StatefulWidget {
  Farmer? user = null;
  @override
  _Fed_FishesState createState() => _Fed_FishesState();
}

class _Fed_FishesState extends State<Fed_Fishes> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); //this
  bool loading = false;
  String error_msg='';
  Map args = {};
  final current_fish_feed = TextEditingController();
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
                  padding: EdgeInsets.symmetric(horizontal: 65, vertical: 5),
                  child: TextFormField(
                    controller: current_fish_feed,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: args['bangla']?'দৈনিক খাবারের পরিমাণ(গ্রাম)':'Amount of daily food(gm)',
                      filled: true,
                      fillColor: Color(0xFFD2ECF2),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
                SizedBox(height: 25),
                Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      minimumSize: const Size(170, 30),
                      maximumSize: const Size(230, 50),
                      foregroundColor: Color(0xFFD2ECF2),
                      backgroundColor: Color(0xFF186B9A),
                    ),
                    onPressed: () async {
                      if(loading) return;
                      loading = true;
                      setState(() {});
                      if(current_fish_feed.text==''){
                        error_msg=(args['bangla']?'ফর্ম পূরণ করুন':'Please fill up the form');
                        loading=false;
                        setState(() {});
                        return;
                      }
                      var no_of_caught_fishes;
                      var avg_w_of_caught_fishes;
                      var farm = await FirebaseFirestore.instance.collection('farms')
                          .doc(widget.user?.phone)
                          .collection('specific_farms')
                          .doc(args['id']);
                      var daily_info = await farm.collection('daily_info');
                      await daily_info.doc(args['entry_date']).get().then((docsnap){
                        if(docsnap.exists){
                          no_of_caught_fishes = docsnap.get('no_of_caught_fishes');
                          avg_w_of_caught_fishes = docsnap.get('avg_w_of_caught_fishes');
                        }
                        else{
                          no_of_caught_fishes = '0';
                          avg_w_of_caught_fishes = '0';
                        }
                      });
                      await daily_info.doc(args['entry_date']).set({
                        'current_fish_feed': current_fish_feed.text,
                        'no_of_caught_fishes': no_of_caught_fishes,
                        'avg_w_of_caught_fishes': avg_w_of_caught_fishes,
                      });
                      var farm_data;
                      await farm.get().then((farmsnap){
                        farm_data = farmsnap;
                      });
                      loading = false;
                      setState(() {});
                      Navigator.pushNamed(context, '/specific_farm', arguments: {
                        'bangla': args['bangla'],
                        'farm_data': farm_data,
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0,10,0,5),
                      child: loading?SpinKitRing(
                        color: Color(0xFFD2ECF2),
                        size: 30.0,
                      )
                          :Text(
                        args['bangla']?'আপডেট করুন':'Update',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                error_msg!=''?Text(
                  error_msg,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                  //textAlign: TextAlign.justify,
                  softWrap: true,
                ):SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
