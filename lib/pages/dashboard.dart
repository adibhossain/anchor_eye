import 'package:flutter/material.dart';
import 'navbar.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); //this
  int i=0;
  List<List<String>> water = [
    ['পিএইচ (pH)',
    'অ্যামোনিয়া',
    'জলের তাপমাত্রা',
    'দ্রবীভূত অক্সিজেন',
    'জলের কঠোরতা'],
    ['মাছের দৈর্ঘ্য',
    'মাছের ওজন']
  ];
  List<Map<String,valcmp>> val = [
    {'পিএইচ (pH)':valcmp(7.4,8.7),
    'অ্যামোনিয়া':valcmp(8.5,8.4),
    'জলের তাপমাত্রা':valcmp(2.3,5.7),
    'দ্রবীভূত অক্সিজেন':valcmp(4.4,8.1),
    'জলের কঠোরতা':valcmp(7.4,6.7)},
    {'মাছের দৈর্ঘ্য':valcmp(15.5,18.4),
    'মাছের ওজন':valcmp(8.5,13.4),}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB9E6FA),
      appBar: AppBar( //this
        backgroundColor: Color(0xFF186B9A),
        centerTitle: true,
        title: Text(
          'রুই খামার - ড্যাশবোর্ড',
          style: TextStyle(
            fontSize: 30.0,
            color: Color(0xFFD2ECF2),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      key: _scaffoldKey, //this
      drawer: NavBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'মাছের বৃদ্ধি',
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
                'জলের গুণমান সূচক',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  IconButton(
                    icon: Image.asset('assets/future.png'),
                    iconSize: 50,
                    onPressed: () {},
                  ),
                  Text(
                    'পূর্বাভাস',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 180),
              Column(
                children: [
                  IconButton(
                    icon: Image.asset('assets/bulb.png'),
                    iconSize: 50,
                    onPressed: () {},
                  ),
                  Text(
                    'পরামর্শ',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
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
                          Navigator.pushNamed(context, '/dashdetail');
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
                                        'বর্তমান',
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
                                        'আদর্শ',
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