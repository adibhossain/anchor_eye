import 'package:anchor_eye/pages/used_fertilizer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'navbar.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); //this
  Map args = {};
  int i=0;
  bool seemore=false;
  List<List<String>> water = [];
  List<Map<String,valcmp>> val = [];
  List<_UpdateData> data = [];

  Future loadData() async {
    var daily_info;
    await args['farm_data'].reference.collection('daily_info').get().then((docsnap){
      daily_info = docsnap.docs;
    });
    //print(daily_info);
    for(var snap in daily_info){
      List<_FertilizerData> fertilizers = [];
      var used_fertilizers;
      await args['farm_data'].reference.collection('daily_info').doc(snap.id).collection('used_fertilizers').get().then((innerdocsnap){
        used_fertilizers = innerdocsnap.docs;
      });
      var i=0;
      for(var innersnap in used_fertilizers){
        var amount = await double.parse(innersnap.get(innersnap.id));
        fertilizers.add(_FertilizerData(innersnap.id,amount));
        i++;
      }
      data.add(_UpdateData(snap.id,
          snap.get('no_of_caught_fishes'),
          snap.get('avg_w_of_caught_fishes'),
          snap.get('current_fish_feed'),
          fertilizers
      ));
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)?.settings.arguments as Map;
    water = [
      [args['bangla']?'পিএইচ (pH)':'pH',
        args['bangla']?'অ্যামোনিয়া':'Ammonia',
        args['bangla']?'জলের তাপমাত্রা':'Temperature',
        args['bangla']?'দ্রবীভূত অক্সিজেন':'Dissolved Oxygen',
        args['bangla']?'জলের কঠোরতা':'Water Hardness'],
      [args['bangla']?'মাছের দৈর্ঘ্য':'Fish Length',
        args['bangla']?'মাছের ওজন':'Fish Weight',]
    ];
    val = [
      {(args['bangla']?'পিএইচ (pH)':'pH'):valcmp(7.4,8.7),
        (args['bangla']?'অ্যামোনিয়া':'Ammonia'):valcmp(8.5,8.4),
        (args['bangla']?'জলের তাপমাত্রা':'Temperature'):valcmp(2.3,5.7),
        (args['bangla']?'দ্রবীভূত অক্সিজেন':'Dissolved Oxygen'):valcmp(4.4,8.1),
        (args['bangla']?'জলের কঠোরতা':'Water Hardness'):valcmp(7.4,6.7)},
      {(args['bangla']?'মাছের দৈর্ঘ্য':'Fish Length'):valcmp(15.5,18.4),
        (args['bangla']?'মাছের ওজন':'Fish Weight'):valcmp(8.5,13.4),}
    ];
    return Scaffold(
      backgroundColor: Color(0xFFB9E6FA),
      appBar: AppBar( //this
        backgroundColor: Color(0xFF186B9A),
        centerTitle: true,
        title: Text(
          (args['bangla']?'ড্যাশবোর্ড':'Dashboard'),
          style: TextStyle(
            fontSize: 30.0,
            color: Color(0xFFD2ECF2),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      key: _scaffoldKey, //this
      drawer: NavBar(bangla: args['bangla']),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 30),
              Text(
                args['bangla']?'খামারের তথ্য: ':'Farm Info: ',
                style: TextStyle(
                  fontSize: 30.0,
                  color: Color(0xFF0A457C),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Card(
                    color: Color(0xFFD7F1F6),
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        //debugPrint('Card tapped.');
                      },
                      child: SizedBox(
                        width: 325,
                        height: seemore?420:140,
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        args['bangla']?'খামারের নাম: ':'Farm Name: ',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Color(0xFF0A457C),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        args['farm_data'].id,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Color(0xFF0A457C),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 40),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        args['bangla']?'মাছের ধরন:':'Fish Species: ',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Color(0xFF0A457C),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        args['farm_data'].get('fish_type'),
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
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 10),
                                Text(
                                  args['bangla']?'মাছের প্রাথমিক সংখ্যা: ':'Initial number of fishes: ',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Color(0xFF0A457C),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  args['farm_data'].get('initial_fish_population'),
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
                                  args['bangla']?'মাছ ছাড়ার তারিখ : ':'Fish Release Date: ',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Color(0xFF0A457C),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  args['farm_data'].get('fish_release_date'),
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Color(0xFF0A457C),
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                                onPressed: () async {
                                  if(!seemore && data.length==0){
                                    await loadData();
                                  }
                                  seemore = !seemore;
                                  setState(() {});
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      seemore?
                                      (args['bangla']?'কম দেখুন':'See Less'):
                                      (args['bangla']?'আরও দেখুন':'See More'),
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Color(0xFF0A457C),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Icon(seemore?Icons.arrow_drop_up:Icons.arrow_drop_down, color: Color(0xFF0A457C)),
                                    SizedBox(width: 20),
                                  ],
                                ),
                            ),
                            seemore?Theme(
                              data: Theme.of(context).copyWith(
                                  cardColor: Color(0xFFD7F1F6),
                                  dividerColor: Color(0xFFB9E6FA),
                              ),
                              child: PaginatedDataTable(
                                //sortColumnIndex: 1,
                                header: Center(
                                  child: Text(
                                    args['bangla']?'আরো তথ্য':'More Info',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Color(0xFF0A457C),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                columns: <DataColumn>[
                                  DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        args['bangla']?'তারিখ':'Date',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Color(0xFF0A457C),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        args['bangla']?'ধরা মাছের\nসংখ্যা':'Caught Fish\nCount',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Color(0xFF0A457C),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        args['bangla']?'ধরা মাছের\nগড় ওজন\n(গ্রাম)':'Caught Fish\nAvg Weight\n(gm)',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Color(0xFF0A457C),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        args['bangla']?'বর্তমান দৈনিক\nখাবার(গ্রাম)':'Current\nDaily Feed\n(gm)',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Color(0xFF0A457C),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        args['bangla']?'ব্যবহৃত সার':'Used\nFertilizer',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Color(0xFF0A457C),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                                source: MyData(args,context,data),
                                columnSpacing: 20,
                                horizontalMargin: 10,
                                rowsPerPage: 2,
                                showCheckboxColumn: false,
                              ),
                            ):SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 50,
                thickness: 1,
                indent: 30,
                endIndent: 30,
                color: Color(0xFF0A457C),
              ),
              Text(
                args['bangla']?'খামারের অবস্থা: ':'Farm Status: ',
                style: TextStyle(
                  fontSize: 30.0,
                  color: Color(0xFF0A457C),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    args['bangla']?'মাছের বৃদ্ধি':'Fish Growth',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: i==1?FontWeight.bold:FontWeight.normal,
                    ),
                  ),
                  IconButton(
                    icon: Image.asset('assets/slide'+i.toString()+'.png'),
                    iconSize: 40,
                    onPressed: () {
                      i++;
                      i%=2;
                      setState(() {});
                    },
                  ),
                  Text(
                    args['bangla']?'জলের গুণমান সূচক':'Water Quality Index',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: i==0?FontWeight.bold:FontWeight.normal,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    icon: Image(
                      image: AssetImage('assets/future.png'),
                      height: 30.0,
                      width: 30.0,
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      minimumSize: const Size(40,40),
                      foregroundColor: Color(0xFFD2ECF2),
                      backgroundColor: Color(0xFF186B9A),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/prediction', arguments: {
                        'bangla': args['bangla'],
                        'i': i,
                        'farm_name': args['farm_name'],
                      });
                    },
                    label: Text(
                      args['bangla']?'পূর্বাভাস':'Prediction',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  //SizedBox(width: 100),
                  ElevatedButton.icon(
                    icon: Image(
                      image: AssetImage('assets/bulb.png'),
                      height: 30.0,
                      width: 30.0,
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      minimumSize: const Size(40, 40),
                      foregroundColor: Color(0xFFD2ECF2),
                      backgroundColor: Color(0xFF186B9A),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/suggestion', arguments: {
                        'bangla': args['bangla'],
                        'i': i,
                        'farm_name': args['farm_name'],
                      });
                    },
                    label: Text(
                      args['bangla']?'পরামর্শ':'Suggestion',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              SizedBox(
                height: 110,
                width: 325,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: water[i].length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Card(
                        shape: water[i][index]==(args['bangla']?'পিএইচ (pH)':'pH')?Border.all(
                          color: Colors.red,
                          width: 2,
                        ):null,
                        color: Color(0xFFF0E8EA),
                        child: InkWell(
                          splashColor: Colors.blue.withAlpha(30),
                          onTap: () {
                            Navigator.pushNamed(context, '/dashdetail', arguments: {
                              'bangla': args['bangla'],
                            });
                          },
                          child: SizedBox(
                            width: 170,
                            height: 50,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  water[i][index],
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          args['bangla']?'বর্তমান':'Current',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          (val[i][water[i][index]]?.data).toString(),
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 15),
                                    Column(
                                      children: [
                                        Text(
                                          args['bangla']?'আদর্শ':'Ideal',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          (val[i][water[i][index]]?.ideal).toString(),
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                ),
              ),
              SizedBox(height: 40.0),
            ],
          ),
        ),
      ),
    );
  }
}
class valcmp {
  valcmp(this.data, this.ideal);
  final double data;
  final double ideal;
  print(){
    debugPrint(data.toString());
    debugPrint(ideal.toString());
  }
}

class _FertilizerData {
  _FertilizerData(this.name, this.amount);
  final String name;
  final double amount;
}

class _UpdateData {
  _UpdateData(this.date, this.caught_fishes, this.avg_weight, this.cur_daily_feed, this.used_fertilizers);
  final String date;
  final String caught_fishes;
  final String avg_weight;
  final String cur_daily_feed;
  final List<_FertilizerData> used_fertilizers;
}

class MyData extends DataTableSource {
  MyData(Map this.args, BuildContext this.context, List<_UpdateData> this.data);

  BuildContext context;
  Map args={};
  List<_UpdateData> data = [];

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => data.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    return DataRow(
      cells: <DataCell>[
        DataCell(
            Center(
              child: Text(
                data[index].date,
                style: TextStyle(
                  fontSize: 15.0,
                  //color: Color(0xFFD2ECF2),
                  //fontWeight: FontWeight.bold,
                ),
              ),
            )
        ),
        DataCell(
            Center(
              child: Text(
                data[index].caught_fishes.toString(),
                style: TextStyle(
                  fontSize: 15.0,
                  //color: Color(0xFFD2ECF2),
                  //fontWeight: FontWeight.bold,
                ),
              ),
            )
        ),
        DataCell(
            Center(
              child: Text(
                data[index].avg_weight.toString(),
                style: TextStyle(
                  fontSize: 15.0,
                  //color: Color(0xFFD2ECF2),
                  //fontWeight: FontWeight.bold,
                ),
              ),
            )
        ),
        DataCell(
            Center(
              child: Text(
                data[index].cur_daily_feed.toString(),
                style: TextStyle(
                  fontSize: 15.0,
                  //color: Color(0xFFD2ECF2),
                  //fontWeight: FontWeight.bold,
                ),
              ),
            )
        ),
        DataCell(
            Center(
              child: Row(
                children: [
                  Text(
                    data[index].used_fertilizers.length.toString()+', ',
                    style: TextStyle(
                      fontSize: 15.0,
                      //color: Color(0xFFD2ECF2),
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/fertilizers', arguments: {
                        'bangla': args['bangla'],
                        'data': data[index].used_fertilizers,
                        'date': data[index].date,
                      });
                    },
                    child: Text(
                      args['bangla']?'আরো':'More',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            )
        ),
      ],
    );
  }
}