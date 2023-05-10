import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import 'navbar.dart';

class Add_farm extends StatefulWidget {
  Farmer? user = null;
  @override
  _Add_farmState createState() => _Add_farmState();
}

class _Add_farmState extends State<Add_farm> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); //this
  Map args = {};
  var fertilizer_cnt=0;
  final farm_name = TextEditingController();
  final fish_type = TextEditingController();
  final initial_fish_population = TextEditingController();
  final fish_release_date = TextEditingController();

  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
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
          args['bangla']?'খামার যোগ করুন':'Add Farm',
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
                    controller: farm_name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: args['bangla']?'খামারের নাম':'Farm Name',
                      filled: true,
                      fillColor: Color(0xFFD2ECF2),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 65, vertical: 5),
                  child: TextFormField(
                    controller: fish_type,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: args['bangla']?'মাছের ধরন':'Fish Species',
                      filled: true,
                      fillColor: Color(0xFFD2ECF2),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 65, vertical: 5),
                  child: TextFormField(
                    controller: initial_fish_population,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: args['bangla']?'মাছের পরিমাণ':'Amount of fish',
                      filled: true,
                      fillColor: Color(0xFFD2ECF2),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 65, vertical: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: fish_release_date,
                        enabled: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: ("${selectedDate.toLocal()}".split(' ')[0]),
                          filled: true,
                          fillColor: Color(0xFFD2ECF2),
                        ),
                      ),
                      SizedBox(height: 3),
                      Container(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(),
                            minimumSize: const Size(250, 30),
                            foregroundColor: Color(0xFFD2ECF2),
                            backgroundColor: Color(0xFF186B9A),
                          ),
                          onPressed: () {
                            _selectDate(context);
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(0,10,0,5),
                            child: Text(
                              args['bangla']?'মাছ ছাড়ার তারিখ':'Date of releasing fish',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 65, vertical: 5),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: args['bangla']?'খাবারের পরিমাণ':'Amount of food',
                      filled: true,
                      fillColor: Color(0xFFD2ECF2),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 65, vertical: 5),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: args['bangla']?'প্রয়োগকৃত সার':'Used Fertilizers',
                      filled: true,
                      fillColor: Color(0xFFD2ECF2),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 65, vertical: 5),
                  child: TextField(
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
                    onSubmitted: (val){
                      fertilizer_cnt = int.parse(val);
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
                            child: TextField(
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
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: args['bangla']?'পরিমাণ(গ্রাম)':'Amount(gm)',
                                filled: true,
                                fillColor: Color(0xFFD2ECF2),
                              ),
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
                      foregroundColor: Color(0xFFD2ECF2),
                      backgroundColor: Color(0xFF186B9A),
                    ),
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection('farms')
                          .doc(widget.user?.phone)
                          .collection('specific_farms')
                          .doc(farm_name.text).set({
                        'fish_type': fish_type.text,
                        'initial_fish_population': initial_fish_population.text,
                        'fish_release_date': ("${selectedDate.toLocal()}".split(' ')[0]),
                      });
                      Navigator.pushNamed(context, '/yourfishfarms', arguments: {
                        'bangla': args['bangla'],
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0,10,0,5),
                      child: Text(
                        args['bangla']?'যোগ করুন':'Add',
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
      ),
    );

  }
}
