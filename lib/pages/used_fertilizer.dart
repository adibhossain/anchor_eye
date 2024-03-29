import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import 'navbar.dart';

class Used_Fertilizer extends StatefulWidget {
  Farmer? user = null;
  @override
  _Used_FertilizerState createState() => _Used_FertilizerState();
}

class _Used_FertilizerState extends State<Used_Fertilizer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); //this
  bool loading = false;
  String error_msg='';
  Map args = {};
  var fertilizer_cnt=0;
  final used_fert_cnt_controller = TextEditingController();
  List<TextEditingController> fertilizer_name = [];
  List<TextEditingController> fertilizer_amount = [];
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
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: TextFormField(
                    controller: used_fert_cnt_controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: args['bangla']?'প্রয়োগকৃত সারের ধরণের সংখ্যা':'Used Number of Fertilizer Types',
                      filled: true,
                      fillColor: Color(0xFFD2ECF2),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (val){
                      if(used_fert_cnt_controller.text==''){
                        error_msg='';
                        fertilizer_cnt = 0;
                        fertilizer_name.clear();
                        fertilizer_amount.clear();
                        setState(() {});
                        return;
                      }
                      if(int.parse(val)>10){
                        error_msg = 'Please enter not more than 10 fertilizers';
                        fertilizer_cnt = 0;
                        fertilizer_name.clear();
                        fertilizer_amount.clear();
                        setState(() {});
                        return;
                      }
                      fertilizer_cnt = int.parse(val);
                      fertilizer_name.clear();
                      fertilizer_amount.clear();
                      for(var i=0;i<fertilizer_cnt;i++){
                        fertilizer_name.add(TextEditingController());
                        fertilizer_amount.add(TextEditingController());
                      }
                      error_msg='';
                      setState(() {});
                      //debugPrint(int.parse(val).toString());
                    },
                  ),
                ),
                SizedBox(
                  height: fertilizer_cnt<=3?(fertilizer_cnt*70):210,
                  child: ListView.builder(
                    itemCount: fertilizer_cnt,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 185,
                            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                            child: TextFormField(
                              controller: fertilizer_name[index],
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: args['bangla']?'সারের নাম':'Fertilizer Name',
                                filled: true,
                                fillColor: Color(0xFFD2ECF2),
                              ),
                            ),
                          ),
                          Container(
                            width: 185,
                            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                            child: TextFormField(
                              controller: fertilizer_amount[index],
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: args['bangla']?'পরিমাণ(গ্রাম)':'Amount(gm)',
                                filled: true,
                                fillColor: Color(0xFFD2ECF2),
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                        ],
                      );
                    },
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
                      bool fillup=false;
                      if(fertilizer_cnt==0) fillup=true;
                      for(var i=0;i<fertilizer_cnt;i++) if(fertilizer_name[i].text=='' || fertilizer_amount[i].text=='') fillup=true;
                      if(fillup){
                        error_msg=(args['bangla']?'ফর্ম পূরণ করুন':'Please fill up the form');
                        loading=false;
                        setState(() {});
                        return;
                      }
                      var no_of_caught_fishes;
                      var avg_w_of_caught_fishes;
                      var cur_feed;
                      var farm = await FirebaseFirestore.instance.collection('farms')
                          .doc(widget.user?.phone)
                          .collection('specific_farms')
                          .doc(args['id']);
                      var daily_info = await farm.collection('daily_info');
                      await daily_info.get().then((docsnap){
                        cur_feed = docsnap.docs.last.get('current_fish_feed');
                      });
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
                        'current_fish_feed': cur_feed,
                        'no_of_caught_fishes': no_of_caught_fishes,
                        'avg_w_of_caught_fishes': avg_w_of_caught_fishes,
                      });
                      final fertilizer_ref = await daily_info.doc(args['entry_date']).collection('used_fertilizers');
                      for(var i=0;i<fertilizer_cnt;i++){
                        await fertilizer_ref.doc(fertilizer_name[i].text).set({
                          fertilizer_name[i].text:fertilizer_amount[i].text
                        });
                        //print(fertilizer_name[i].text+" fertilizer of amount "+fertilizer_amount[i].text);
                      }
                      var farm_data;
                      await farm.get().then((farmsnap){
                        farm_data = farmsnap;
                      });
                      loading=false;
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
