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
  List<List<String>> water = [];
  List<Map<String,valcmp>> val = [];
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
          args['bangla']?'রুই খামার - ড্যাশবোর্ড':'Rui Farm - Dashboard',
          style: TextStyle(
            fontSize: 30.0,
            color: Color(0xFFD2ECF2),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      key: _scaffoldKey, //this
      drawer: NavBar(bangla: args['bangla']),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                args['bangla']?'মাছের বৃদ্ধি':'Fish Growth',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
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
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                icon: Image.asset('assets/future.png'),
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  minimumSize: const Size(80,55),
                  foregroundColor: Color(0xFFD2ECF2),
                  backgroundColor: Color(0xFF186B9A),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/prediction', arguments: {
                    'bangla': args['bangla'],
                    'i': i,
                  });
                },
                label: Text(
                  args['bangla']?'পূর্বাভাস':'Prediction',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              //SizedBox(width: 100),
              ElevatedButton.icon(
                icon: Image.asset('assets/bulb.png'),
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  minimumSize: const Size(80, 30),
                  foregroundColor: Color(0xFFD2ECF2),
                  backgroundColor: Color(0xFF186B9A),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/suggestion', arguments: {
                    'bangla': args['bangla'],
                    'i': i,
                  });
                },
                label: Text(
                  args['bangla']?'পরামর্শ':'Suggestion',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Expanded(
            child: SizedBox(
              height: 200,
              width: 200,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: water[i].length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return Card(
                      color: Color(0xFFF0E8EA),
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          Navigator.pushNamed(context, '/dashdetail', arguments: {
                            'bangla': args['bangla'],
                          });
                        },
                        child: SizedBox(
                          width: 150,
                          height: 100,
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
          ),
          SizedBox(height: 40.0),
        ],
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