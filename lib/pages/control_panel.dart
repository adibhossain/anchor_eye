import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert' as convert;

import 'navbar.dart';

class ControlPanel extends StatefulWidget {
  @override
  _ControlPanelState createState() => _ControlPanelState();
}

class _ControlPanelState extends State<ControlPanel> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Map args = {};
  bool hints=false, sampling=false, motor=false, battery_alert_showing=false;
  var bat_context;
  var pi_ip;
  final month_name = ['','January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
  final season = ['','Winter', 'Winter', 'Summer', 'Summer', 'Summer', 'Rainy', 'Rainy', 'Rainy', 'Rainy', 'Rainy', 'Winter', 'Winter'];
  final gap = 50.0;
  final button_size=60.0;
  var i=0;
  var p1=0;
  double progress = -1.0;
  double _currentSliderValue = 1000;
  double _lastSliderValue = 1000;
  int n=0;
  String temp='N/A',ph='N/A',turb='N/A',DO='N/A',nit='N/A',fish_growth='N/A',fish_length='N/A',fish_weight='N/A';
  late Timer _timer;

  Future<void> stopmotor() async{
    print('wanna control u');
    if(motor){
      motor=false;
      _lastSliderValue=_currentSliderValue=1000;
      setState(() {});
    }
    var url = Uri.parse(pi_ip+':5000/api/control?p1=0&p2='+_lastSliderValue.toString());
    try{
      var response = await http.get(url).timeout(Duration(seconds: 5));
      print('Response body: ${response.body}');
      //var jsonResponse = convert.jsonDecode(response.body);
      p1=0;
    }catch(e){
      motor=false;
      _lastSliderValue=_currentSliderValue=1000;
      setState(() {});
      stopDataUpdates();
      Navigator.pushNamed(context, '/connect_pi', arguments: {
        'bangla': args['bangla'],
        'farm_data': args['farm_data'],
        'failed': true,
      });
      //print(e);
    }
  }

  Future<void> take_sample() async{
    var url1 = Uri.parse(pi_ip+':5000/api/hello?p1=s');
    var url2 = Uri.parse(pi_ip+':5000/get_length');
    try{
      var response1 = await http.get(url1).timeout(Duration(seconds: 10));
      var response2 = await http.get(url2).timeout(Duration(seconds: 10));
      // if response.statuscode == 200 else
      print('Response body: ${response1.body}');
      var jsonResponse = convert.jsonDecode(response1.body);
      var jsonResponse2 = convert.jsonDecode(response2.body);
      if(n==0){
        temp=jsonResponse['temp'];
        ph=jsonResponse['ph'];
        turb=jsonResponse['turb'];
        DO=jsonResponse['do'];
        nit=jsonResponse['nit'];
        fish_length=jsonResponse2['avg_length'];
        fish_weight=jsonResponse2['avg_weight'];
      }
      else{
        double fetched=double.parse(jsonResponse['temp']),avg=double.parse(temp);
        avg = (n/(n+1))*avg + (fetched/(n+1));
        temp = avg.toStringAsFixed(2);

        fetched=double.parse(jsonResponse['ph']);avg=double.parse(ph);
        avg = (n/(n+1))*avg + (fetched/(n+1));
        ph = avg.toStringAsFixed(2);

        fetched=double.parse(jsonResponse['turb']);avg=double.parse(turb);
        avg = (n/(n+1))*avg + (fetched/(n+1));
        turb = avg.toStringAsFixed(2);

        fetched=double.parse(jsonResponse['do']);avg=double.parse(DO);
        avg = (n/(n+1))*avg + (fetched/(n+1));
        DO = avg.toStringAsFixed(2);

        fetched=double.parse(jsonResponse['nit']);avg=double.parse(nit);
        avg = (n/(n+1))*avg + (fetched/(n+1));
        nit = avg.toStringAsFixed(2);

        fetched=double.parse(jsonResponse2['avg_length']);avg=double.parse(fish_length);
        avg = (n/(n+1))*avg + (fetched/(n+1));
        fish_length = avg.toStringAsFixed(2);

        fetched=double.parse(jsonResponse2['avg_weight']);avg=double.parse(fish_weight);
        avg = (n/(n+1))*avg + (fetched/(n+1));
        fish_weight = avg.toStringAsFixed(2);
      }
      n++;
    }catch(e){
      print(e);
      stopDataUpdates();
      Navigator.pushNamed(context, '/connect_pi', arguments: {
        'bangla': args['bangla'],
        'farm_data': args['farm_data'],
        'failed': true,
      });
    }
  }

  Future<void> power_off() async{
    await stopmotor();
    DateTime selectedDate = DateTime.now();
    print('hello from flutter');

    // Send request to shutdown motors first then do the following
    if(n==0) await take_sample();
    print('hell');
    try{
      var cur_time = "${selectedDate.toLocal()}".split(' ')[0].split('-');
      var month = int.parse(cur_time[1]);
      var tot_cur_time = (int.parse(cur_time[0])*365) + (int.parse(cur_time[1])*30) + (int.parse(cur_time[2]));
      double prev_length = 0.0;
      double cur_length=double.parse(fish_length);
      var tot_prev_time = tot_cur_time;
      await args['farm_data'].reference.collection('params').get().then((docsnap) async {
        if(docsnap.docs.length==0){
          print("no param found");
          var temp2 = await args['farm_data'].get('initial_fish_length');
          var temp1 = await args['farm_data'].get('fish_release_date');
          var prev_time = temp1.split('-');
          tot_prev_time = (int.parse(prev_time[0])*365) + (int.parse(prev_time[1])*30) + (int.parse(prev_time[2]));
          if(tot_prev_time==tot_cur_time){
            prev_length = cur_length;
          }
          else prev_length = double.parse(temp2);
        }
        else {
          var fetch = await docsnap.docs.last.get('fish_length');
          var temp3 = await docsnap.docs.last.id;
          var prev_time = temp3.split('-');
          tot_prev_time = (int.parse(prev_time[0])*365) + (int.parse(prev_time[1])*30) + (int.parse(prev_time[2]));
          if(tot_prev_time==tot_cur_time){
            int indexi = await docsnap.docs.length;
            if(indexi>1){
              fetch = await docsnap.docs[indexi-2].get('fish_length');
              temp3 = await docsnap.docs[indexi-2].id;
              prev_time = temp3.split('-');
              tot_prev_time = (int.parse(prev_time[0])*365) + (int.parse(prev_time[1])*30) + (int.parse(prev_time[2]));
              prev_length = double.parse(fetch);
            }
            else{
              prev_length = cur_length;
            }
          }
          else prev_length = double.parse(fetch);
        }
      });
      var tot_month_elapsed = (tot_cur_time-tot_prev_time)/30;
      if(tot_month_elapsed==0) tot_month_elapsed=1; //this needs to be addressed later
      double growth = (cur_length-prev_length)/tot_month_elapsed;
      fish_growth = growth.toStringAsFixed(2);
      await args['farm_data'].reference.collection('params').doc("${selectedDate.toLocal()}".split(' ')[0]).set({
        'DO':DO,
        'nitrate':nit,
        'fish_growth': fish_growth,
        'fish_length':fish_length,
        'fish_weight':fish_weight,
        'month':month_name[month],
        'season':season[month],
        'pH':ph,
        'temperature':temp,
        'turbidity':turb,
        'n':n.toString(),
      });
    }catch(e){
      print(e);
    }
    //print('Response status: ${response.statusCode}');
    stopDataUpdates();
    Navigator.pushNamed(context, '/specific_farm', arguments: {
      'bangla': args['bangla'],
      'farm_data': args['farm_data'],
    });
  }

  void _showBatteryAlert(BuildContext context) {
    if(battery_alert_showing) return;
    battery_alert_showing=true;
    if(progress>0.3) return;
    var title_exclamations,content;
    var closebutton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
        foregroundColor: Color(0xFFD2ECF2),
        backgroundColor: Color(0xFF186B9A),
      ),
      onPressed: () {
        battery_alert_showing=false;
        Navigator.of(context).pop();
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(0,5,0,5),
        child: Text(
          args['bangla']?'ঠিক আছে':'Okay',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    disconnect_button = ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
        foregroundColor: Color(0xFFD2ECF2),
        backgroundColor: Color(0xFF186B9A),
      ),
      onPressed: () async{
        if(sampling) return;
        battery_alert_showing=false;
        Navigator.of(context).pop();
        sampling=true;
        setState(() {});
        await power_off();
        sampling=false;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(0,5,0,5),
        child: Text(
          args['bangla']?'সংযোগ বিচ্ছিন্ন':'Disconnect',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    List<Widget> actions_list = [];
    var dismissable;
    if(progress>0.2){
      title_exclamations=' !';
      content=args['bangla']?'ব্যাটারি কম: ':'Battery is low: ';
      actions_list.add(closebutton);
      dismissable=true;
    }
    else if(progress>0.1){
      title_exclamations=' !!';
      content=args['bangla']?'ব্যাটারি খুব কম: ':'Battery is very low: ';
      actions_list.add(closebutton);
      actions_list.add(disconnect_button);
      dismissable=true;
    }
    else{
      title_exclamations=' !!!';
      content=args['bangla']?'ব্যাটারি অত্যন্ত কম: ':'Battery is extremely low: ';
      actions_list.add(disconnect_button);
      dismissable=false;
    }
    showDialog(
      barrierDismissible: dismissable,
      context: context,
      builder: (BuildContext context) {
        bat_context=context;
        return AlertDialog(
          title: Text(
            (args['bangla']?'সতর্কতা':'Warning')+title_exclamations,
            style: TextStyle(
              fontSize: 30.0,
              color: Color(0xFF0A457C),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            content+(progress*100).round().toString()+"%",
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

  void _showFetchedData(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Center(
                child: Text(
                  (args['bangla']?'আনা ডেটা':'Fetched Data'),
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Color(0xFF0A457C),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              content: Container(
                height: 190,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 10),
                        Text(
                          (!args['bangla']?'পিএইচ (pH)':'pH')+' = ',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Color(0xFF0A457C),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ph,
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Color(0xFF0A457C),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 10),
                        Text(
                          (args['bangla']?'নাইট্রেট':'Nitrate')+' = ',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Color(0xFF0A457C),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          nit,
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Color(0xFF0A457C),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 10),
                        Text(
                          (args['bangla']?'জলের তাপমাত্রা':'Temperature')+' = ',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Color(0xFF0A457C),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          temp,
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Color(0xFF0A457C),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 10),
                        Text(
                          (args['bangla']?'দ্রবীভূত অক্সিজেন':'Dissolved Oxygen')+' = ',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Color(0xFF0A457C),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          DO,
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Color(0xFF0A457C),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 10),
                        Text(
                          (args['bangla']?'জলের অস্বচ্ছতা':'Turbidity')+' = ',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Color(0xFF0A457C),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          turb,
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Color(0xFF0A457C),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 10),
                        Text(
                          (args['bangla']?'মাছের দৈর্ঘ্য':'Fish Length')+' = ',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Color(0xFF0A457C),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          fish_length,
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Color(0xFF0A457C),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 10),
                        Text(
                          (args['bangla']?'মাছের ওজন':'Fish Weight')+' = ',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Color(0xFF0A457C),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          fish_weight,
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Color(0xFF0A457C),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    foregroundColor: Color(0xFFD2ECF2),
                    backgroundColor: Color(0xFF186B9A),
                  ),
                  onPressed: () {
                    if(n==0) return;
                    temp='N/A';ph='N/A';turb='N/A';DO='N/A';nit='N/A';fish_growth='N/A';fish_length='N/A';fish_weight='N/A';
                    n=0;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0,5,0,5),
                    child: Text(
                      args['bangla']?'বাতিল করুন':'Discard Data',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    foregroundColor: Color(0xFFD2ECF2),
                    backgroundColor: Color(0xFF186B9A),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0,5,0,5),
                    child: Text(
                      args['bangla']?'ঠিক আছে':'Okay',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
              backgroundColor: Color(0xFFB9E6FA),
              actionsPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
            );
          }
        );
      },
    );
  }

  Future<void> fetch_battery() async{
    if(battery_alert_showing){
      battery_alert_showing=false;
      Navigator.of(bat_context).pop();
    }
    var url = Uri.parse(pi_ip+':5000/api/bat');
    try{
      var response = await http.get(url).timeout(Duration(seconds: 5));
      // if response.statuscode == 200 else
      print('Response body: ${response.body}');
      var jsonResponse = convert.jsonDecode(response.body);
      progress=double.parse(jsonResponse['Battery']);
      //progress=0.15;
      setState(() {});
      _showBatteryAlert(context);
    }catch(e){
      print(e);
      stopDataUpdates();
      Navigator.pushNamed(context, '/connect_pi', arguments: {
        'bangla': args['bangla'],
        'farm_data': args['farm_data'],
        'failed': true,
      });
    }
  }

  void startDataUpdates() {
    const interval = Duration(seconds: 300);
    _timer = Timer.periodic(interval, (timer) async{
      if(sampling) return;
      sampling=true;
      setState(() {});
      await fetch_battery();
      sampling=false;
      setState(() {});
    });
  }

  void stopDataUpdates() {
    _timer.cancel();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      _showBatteryAlert(context);
    });
    startDataUpdates();
  }
  
  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)?.settings.arguments as Map;
    pi_ip = args['pi_ip'];
    if(progress==-1.0) progress=args['bat'];
    return Scaffold(
      floatingActionButton: Visibility(
        visible: sampling,
        child: FloatingActionButton(
          mini: true,
          elevation: 0.0,
          tooltip: args['bangla']?'অনুগ্রহ করে অপেক্ষা করুন...':'Please wait...',
          onPressed: () {},
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: SpinKitRing(
              color: Color(0xFF0A457C),
              size: 40.0,
            ),
          ),
          backgroundColor: Color(0xFFB9E6FA),
        ),
      ),
      backgroundColor: Color(0xFFB9E6FA),
      appBar: AppBar( //this
        backgroundColor: Color(0xFF186B9A),
        centerTitle: true,
        title: Text(
          args['bangla']?'কন্ট্রল প্যানেল':'Control Panel',
          style: TextStyle(
            fontSize: 30.0,
            color: Color(0xFFD2ECF2),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      key: _scaffoldKey, //this
      drawer: NavBar(bangla: args['bangla'], index: -1),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: gap),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      args['bangla']?'সুরোক্ষিত অবস্থা:':'Protected Mode:',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          args['bangla']?'চালু':'On',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: i==1?FontWeight.bold:FontWeight.normal,
                          ),
                        ),
                        IconButton(
                          icon: Image.asset('assets/slide'+i.toString()+'.png'),
                          iconSize: button_size,
                          onPressed: () async{
                            if(sampling) return;
                            sampling=true;
                            setState(() {});
                            i++;
                            i%=2;
                            var url = Uri.parse(pi_ip+':5000/api/control?p1=7&p2='+i.toString());
                            try{
                              var response = await http.get(url).timeout(Duration(seconds: 5)); // .timeout(Duration(seconds: 10))
                              print('Response body: ${response.body}');
                              //var jsonResponse = convert.jsonDecode(response.body);
                              setState(() {});
                            }catch(e){
                              i++;
                              i%=2;
                              setState(() {});
                              stopDataUpdates();
                              Navigator.pushNamed(context, '/connect_pi', arguments: {
                                'bangla': args['bangla'],
                                'farm_data': args['farm_data'],
                                'failed': true,
                              });
                              //print(e);
                            }
                            sampling=false;
                            setState(() {});
                          },
                        ),
                        Text(
                          args['bangla']?'বন্ধ':'Off',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: i==0?FontWeight.bold:FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: 80),
                IconButton(
                  icon: Image.asset('assets/help.png'),
                  iconSize: button_size,
                  onPressed: () {
                    hints=true;
                    setState(() {});
                    Future.delayed(Duration(seconds: 5), () {
                      hints=false;
                      setState(() {});
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: gap),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async{
                        if(sampling) return;
                        sampling=true;
                        setState(() {});
                        await fetch_battery();
                        sampling=false;
                        setState(() {});
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 80,
                            child: LinearProgressIndicator(
                              value: progress,
                              minHeight: 35,
                              color: (progress>0.3?Colors.green:(progress>0.2?Colors.yellow:(progress>0.1?Colors.orange:Colors.red))),
                            ),
                          ),
                          Text(
                            (progress*100).round().toString()+"%",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    hints?Text(
                      args['bangla']?'ব্যাটারি':'Battery',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ):SizedBox.shrink(),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Image.asset('assets/power-off.png'),
                      iconSize: button_size,
                      onPressed: () async{
                        if(sampling) return;
                        sampling=true;
                        setState(() {});
                        await power_off();
                        sampling=false;
                        setState(() {});
                      },
                    ),
                    hints?Text(
                      args['bangla']?'সিস্টেম থামান':'Stop System',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ):SizedBox.shrink(),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Image.asset('assets/sample.png'),
                      iconSize: button_size,
                      onPressed: () async{
                        if(sampling) return;
                        sampling=true;
                        setState(() {});
                        await take_sample();
                        sampling=false;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 5),
                    hints?Text(
                      args['bangla']?'নমুনা নিন':'Take Sample',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ):SizedBox.shrink(),
                  ],
                ),
              ],
            ),
            SizedBox(height: gap),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  args['bangla']?'গতি:':'Speed:',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Slider(
                  value: _currentSliderValue,
                  min: 1000,
                  max: 2000,
                  divisions: 20,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  },
                  onChangeEnd: (double value) async {
                    if(sampling){
                      _currentSliderValue=_lastSliderValue;
                      setState(() {});
                      return;
                    }
                    sampling=true;
                    setState(() {});
                    print(value);print(_currentSliderValue);print(_lastSliderValue);
                    if(motor){
                      if(value==1000){
                        _currentSliderValue=_lastSliderValue;
                        setState(() {});
                        sampling=false;
                        return;
                      }
                      _lastSliderValue=_currentSliderValue;
                      setState(() {});
                      //code to change motor speed
                    }
                    else{
                      if(value>1000){
                        _currentSliderValue=_lastSliderValue;
                        sampling=false;
                        setState(() {});
                        return;
                      }
                      _lastSliderValue=_currentSliderValue;
                      setState(() {});
                    }
                    var url = Uri.parse(pi_ip+':5000/api/control?p1='+p1.toString()+'&p2='+_lastSliderValue.toString());
                    try{
                      var response = await http.get(url).timeout(Duration(seconds: 5)); // .timeout(Duration(seconds: 10))
                      print('Response body: ${response.body}');
                      //var jsonResponse = convert.jsonDecode(response.body);
                    }catch(e){
                      motor=false;
                      _lastSliderValue=_currentSliderValue=1000;
                      setState(() {});
                      stopDataUpdates();
                      Navigator.pushNamed(context, '/connect_pi', arguments: {
                        'bangla': args['bangla'],
                        'farm_data': args['farm_data'],
                        'failed': true,
                      });
                      //print(e);
                    }
                    sampling=false;
                    setState(() {});
                  },
                ),
              ],
            ),
            SizedBox(height: gap),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    IconButton(
                      icon: Image.asset('assets/up.png'),
                      iconSize: button_size,
                      onPressed: () async{
                        if(sampling) return;
                        sampling=true;
                        setState(() {});
                        print('wanna control u');
                        if(!motor){
                          motor=true;
                          _lastSliderValue=_currentSliderValue=1100;
                          setState(() {});
                        }
                        var url = Uri.parse(pi_ip+':5000/api/control?p1=1&p2='+_lastSliderValue.toString());
                        try{
                          var response = await http.get(url).timeout(Duration(seconds: 5)); // .timeout(Duration(seconds: 10))
                          print('Response body: ${response.body}');
                          //var jsonResponse = convert.jsonDecode(response.body);
                          p1=1;
                        }catch(e){
                          motor=false;
                          _lastSliderValue=_currentSliderValue=1000;
                          setState(() {});
                          stopDataUpdates();
                          Navigator.pushNamed(context, '/connect_pi', arguments: {
                            'bangla': args['bangla'],
                            'farm_data': args['farm_data'],
                            'failed': true,
                          });
                          //print(e);
                        }
                        sampling=false;
                        setState(() {});
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: Image.asset('assets/left.png'),
                          iconSize: button_size,
                          onPressed: () async{
                            if(sampling) return;
                            sampling=true;
                            setState(() {});
                            print('wanna control u');
                            if(!motor){
                              motor=true;
                              _lastSliderValue=_currentSliderValue=1100;
                              setState(() {});
                            }
                            var url = Uri.parse(pi_ip+':5000/api/control?p1=2&p2='+_lastSliderValue.toString());
                            try{
                              var response = await http.get(url).timeout(Duration(seconds: 5));
                              print('Response body: ${response.body}');
                              //var jsonResponse = convert.jso  nDecode(response.body);
                              p1=2;
                            }catch(e){
                              motor=false;
                              _lastSliderValue=_currentSliderValue=1000;
                              setState(() {});
                              stopDataUpdates();
                              Navigator.pushNamed(context, '/connect_pi', arguments: {
                                'bangla': args['bangla'],
                                'farm_data': args['farm_data'],
                                'failed': true,
                              });
                              //print(e);
                            }
                            sampling=false;
                            setState(() {});
                          },
                        ),
                        IconButton(
                          icon: Image.asset('assets/stop.png'),
                          iconSize: button_size,
                          onPressed: () async{
                            if(sampling) return;
                            sampling=true;
                            setState(() {});
                            await stopmotor();
                            sampling=false;
                            setState(() {});
                          },
                        ),
                        IconButton(
                          icon: Image.asset('assets/right.png'),
                          iconSize: button_size,
                          onPressed: () async{
                            if(sampling) return;
                            sampling=true;
                            setState(() {});
                            print('wanna control u');
                            if(!motor){
                              motor=true;
                              _lastSliderValue=_currentSliderValue=1100;
                              setState(() {});
                            }
                            var url = Uri.parse(pi_ip+':5000/api/control?p1=3&p2='+_lastSliderValue.toString());
                            try{
                              var response = await http.get(url).timeout(Duration(seconds: 5));
                              print('Response body: ${response.body}');
                              //var jsonResponse = convert.jsonDecode(response.body);
                              p1=3;
                            }catch(e){
                              motor=false;
                              _lastSliderValue=_currentSliderValue=1000;
                              setState(() {});
                              stopDataUpdates();
                              Navigator.pushNamed(context, '/connect_pi', arguments: {
                                'bangla': args['bangla'],
                                'farm_data': args['farm_data'],
                                'failed': true,
                              });
                              //print(e);
                            }
                            sampling=false;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: 10),
                hints?Container(
                  width: 120,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    textAlign: TextAlign.center,
                    args['bangla']?'রোবোটিক বডি মুভমেন্ট':'Robotic Body Movement',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                  ),
                ):SizedBox.shrink(),
              ],
            ),
            SizedBox(height: gap),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                foregroundColor: Color(0xFFD2ECF2),
                backgroundColor: Color(0xFF186B9A),
              ),
              onPressed: () {
                if(sampling) return;
                _showFetchedData(context);
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(0,5,0,5),
                child: Text(
                  args['bangla']?'আনা ডেটা দেখুন':'See Fetched Data',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
