import 'package:flutter/material.dart';
import 'navbar.dart';

class Credit_IDP1 extends StatefulWidget {
  @override
  _Credit_IDP1State createState() => _Credit_IDP1State();
}

class _Credit_IDP1State extends State<Credit_IDP1> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); //this
  Map args = {};
  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
      backgroundColor: Color(0xFFB9E6FA),
      appBar: AppBar( //this
        backgroundColor: Color(0xFF186B9A),
        centerTitle: true,
        title: Text(
          args['bangla']?'ক্রেডিট':'Credits',
          style: TextStyle(
            fontSize: 30.0,
            color: Color(0xFFD2ECF2),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      key: _scaffoldKey, //this
      drawer: NavBar(bangla: args['bangla'],index: 0), //this
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  args['bangla']?'আমাদের সুপারভাইজার':'Our Supervisors',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Color(0xFF0A457C),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/mahbub_sir.png'),
                          radius: 40,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Dr. Md. Mahbubur',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Rahman',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Professor,',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Department of Computer',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          'Science & Engineering (CSE),',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          'Military Institute of',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          'Science & Technology',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/nazrul_sir.png'),
                          radius: 40,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Lt Col Muhammad',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Nazrul Islam, PhD',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Associate Professor,',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Department of Computer',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          'Science & Engineering (CSE),',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          'Military Institute of',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          'Science & Technology',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/jahan_miss.png'),
                      radius: 40,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Dr. Hosney Jahan',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Assistant Professor,',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Department of Computer',
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      'Science & Engineering (CSE),',
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      'Military Institute of',
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      'Science & Technology',
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/nafiz_sir.png'),
                          radius: 40,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Nafiz Imtiaz Khan',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Lecturer,',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Department of Computer',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          'Science & Engineering (CSE),',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          'Military Institute of',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          'Science & Technology',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/medha_miss.png'),
                          radius: 40,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Tasneem Mubashshira',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Lecturer,',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Department of Computer',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          'Science & Engineering (CSE),',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          'Military Institute of',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          'Science & Technology',
                          style: TextStyle(
                            fontSize: 12.0,
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
      ),
    );
  }
}
