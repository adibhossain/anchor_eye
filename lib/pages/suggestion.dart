import 'package:flutter/material.dart';
import 'navbar.dart';

class Suggestion extends StatefulWidget {
  @override
  _SuggestionState createState() => _SuggestionState();
}

class _SuggestionState extends State<Suggestion> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); //this
  Map args = {};
  List<String> msg=[];
  int i=2;
  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)?.settings.arguments as Map;
    msg=[(args['bangla']?'১) পানির পিএইচ হঠ্যাৎ করে কমে গিয়েছে শতাংশে ২০০ গ্রাম হারে ডলোমাইট দিতে হবে। পিএইচ ফ্লাকচুয়েশন এর উপর নির্ভরকরে পর পর ৩ দিন ডলোমাইট দিতে হবে।\n২) রোগ প্রতিরোধের জন্য একরপ্রতি ৪৫-৬০ কেজি চুন প্রয়োগ করতে পারেন। \n৩) বর্তমান শুষ্ক আবহাওয়া ২ সপ্তাহ থাকবে।'
          :'1) pH has dropped suddenly, apply 200gm dolomite by percentage. Depending on the fluctuation of pH apply dolomite for 3 days.\n2) To prevent diseases apply 45-60kg limestone per acre.\n3) Current dry weather will stay for two more weeks.'),
         (args['bangla']?'১) মাছকে দ্রুত বৃদ্ধি করতে ইকোফিসক্যাল এবং ইকোগ্রোথ-প্রমোটর খাওয়ান।\n২) প্রতি কেজি খাবারের সাথে ৫ গ্রাম করে খাওয়াতে হবে।\n'
          :'1) To increase fish growth feed them ecofiscal and ecogrowth-promoter.\n2) Feed 5gm of it per kg.')];
    i=(i==2?args['i']:i);
    return Scaffold(
      backgroundColor: Color(0xFF99CDE3),
      appBar: AppBar(
        backgroundColor: Color(0xFF186B9A),
        centerTitle: true,
        title: Text(
          args['bangla']?'রুই খামার':'Rui Farm',
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
            children: <Widget>[
          Text(
            args['bangla']?'ড্যাশবোর্ড - পরামর্শ':'Dashboard - Suggestion',
           style: TextStyle(
            fontSize: 30.0,
           color: Color(0xFF186B9A),
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 65, vertical: 35),
              ),
              Image(
                image: AssetImage('assets/light.png'),
                height: 70.0,
                width: 60.0,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 65, vertical: 0),
              ),
          Container(
          child: Card(
            color: Color(0xFFD7F1F6),
          child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            //debugPrint('Card tapped.');
            },
            child: SizedBox(
              width: 300,
              height: 250,
              child: Text(msg[i]
              ),
            ),

          ),
        ),
          ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 65, vertical: 20),
              ),



            ],
          ),


        ),
      ),
    );

  }
}
