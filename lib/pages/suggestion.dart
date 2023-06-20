import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'navbar.dart';
import 'dashboard.dart';

class Suggestion extends StatefulWidget {
  @override
  _SuggestionState createState() => _SuggestionState();
}

class _SuggestionState extends State<Suggestion> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); //this
  Map args = {};
  List<String> msg=['',''];
  int i=2;
  List<List<String>> water = [];
  List<Map<String,valcmp>> val = [];
  Map<String,String> whois ={}, units={};
  List<UpdateData> data = [];
  Map<String,double> lower = {};
  Map<String,double> upper = {};
  List<Map<String,String>> if_low = [], if_high = [];
  
  @override
  Widget build(BuildContext context) {
    msg=['',''];
    args = ModalRoute.of(context)?.settings.arguments as Map;
    i=(i==2?args['i']:i);
    water = args['water'];
    whois = args['whois'];
    val = args['val'];
    units = args['units'];
    data = args['data'];
    lower = args['lower'];
    upper = args['upper'];
    if_low = [
      {(args['bangla'] ? 'পিএইচ (pH)' : 'pH'):(args['bangla'] ? 'জলজ শরীরের কম pH সংশোধন করতে কুইকলাইম (CaO) ব্যবহার করুন।' : 'Use of quicklime (CaO) to rectify low pH of aquatic body.'),
      (args['bangla'] ? 'নাইট্রেট' : 'Nitrate'):(args['bangla'] ? 'পুকুরে বিভিন্ন ধরনের জলজ উদ্ভিদ রোপণ করলে প্রাকৃতিকভাবে নাইট্রেটের মাত্রা বৃদ্ধি পেতে পারে।' : 'Planting a variety of aquatic plants in the pond can help increase nitrate levels naturally.'),
      (args['bangla'] ? 'জলের তাপমাত্রা' : 'Temperature'):(args['bangla'] ? 'সর্বাধিক সূর্যালোক এক্সপোজার প্রাকৃতিকভাবে দিনের বেলা জলের তাপমাত্রা বাড়াতে সাহায্য করতে পারে। শীতল তাপমাত্রায়, মাছের বিপাক ধীর হয়ে যায় এবং তাদের খাওয়ানোর প্রয়োজনীয়তা হ্রাস পায়। মাছের বিপাকীয় চাহিদা মেটানোর জন্য তাদের খাওয়ার ফ্রিকোয়েন্সি এবং পরিমাণ কমিয়ে দিন।' : 'Maximizing sunlight exposure can help naturally raise the water temperature during the day. In colder temperatures, fish metabolism slows down, and their feeding requirements decrease. Reduce the frequency and amount of feed provided to the fish to match their reduced metabolic needs.'),
      (args['bangla'] ? 'দ্রবীভূত অক্সিজেন' : 'Dissolved Oxygen'):(args['bangla'] ? 'পানির পুনর্ব্যবহার এবং এয়ারেটর ব্যবহার। কৃত্রিমভাবে বা ম্যানুয়ালি জল পিটানো।' : 'Recycling of water and use of aerators. Artificially or manually beating of water.'),
      (args['bangla'] ? 'জলের অস্বচ্ছতা' : 'Turbidity'):(args['bangla'] ? 'যদি পলল নীচে স্থির হয়, তবে এটি কম ঘোলাটে অবদান রাখতে পারে। অত্যধিক পলি জমে থাকা রোধ করতে পলি অপসারণের কৌশল প্রয়োগ করুন, যেমন ড্রেজিং বা অবক্ষেপন বেসিন।' : 'If sediment is settling at the bottom, it can contribute to low turbidity. Implement sediment removal techniques, such as dredging or sedimentation basins, to prevent excessive sediment accumulation.')},
      {(args['bangla']?'মাছের বৃদ্ধির হার':'Fish Growth Rate'):(args['bangla'] ? 'মাছের বৃদ্ধি বাড়ানোর জন্য তাদের ইকোফিসকাল এবং ইকোগ্রোথ-প্রমোটার খাওয়ান। প্রতি কেজি 5 গ্রাম খাওয়ান।' : 'To increase fish growth feed them ecofiscal and ecogrowth-promoter. Feed 5gm of it per kg.'),
        (args['bangla'] ? 'মাছের দৈর্ঘ্য' : 'Fish Length'):(args['bangla'] ? 'খাওয়ানোর অনুশীলনগুলি পর্যালোচনা করুন এবং নিশ্চিত করুন যে মাছগুলি পর্যাপ্ত এবং সুষম খাদ্য গ্রহণ করছে।' : 'Review the feeding practices and ensure that the fish are receiving an adequate and balanced diet.'),
      (args['bangla'] ? 'মাছের ওজন' : 'Fish Weight'):(args['bangla'] ? 'ব্যবহৃত মাছের খাদ্যের গুণমান পরীক্ষা করুন। নিশ্চিত করুন যে এটি তাজা, সঠিকভাবে সংরক্ষিত এবং রুহি মাছের পুষ্টির প্রয়োজনীয়তা পূরণ করে। নিম্নমানের ফিড বা কম পুষ্টি উপাদান সহ ফিডের ফলে ধীরগতির বৃদ্ধি এবং ওজন কম হতে পারে।' : 'Check the quality of the fish feed being used. Ensure that it is fresh, properly stored, and meets the nutritional requirements of ruhi fish. Poor-quality feed or feed with low nutrient content can result in slower growth and lower weight gain.')},
    ];
    if_high = [
      {(args['bangla'] ? 'পিএইচ (pH)' : 'pH'):(args['bangla'] ? 'জিপসাম (CaSO4) বা জৈব পদার্থ (গোবর, হাঁস-মুরগির বিষ্ঠা ইত্যাদি) যোগ করুন এবং pH মাত্রা কমাতে একটি নতুন কংক্রিটের পুকুরের প্রাথমিক প্রাক-চিকিত্সা বা নিরাময় করুন।' : 'Add gypsum (CaSO4) or organic matter (cowdung, poultry droppings etc.) and initial pre-treatment or curing of a new concrete pond to reduce pH levels.'),
        (args['bangla'] ? 'নাইট্রেট' : 'Nitrate'):(args['bangla'] ? 'মাছকে অতিরিক্ত খাওয়াবেন না। অতিরিক্ত খাদ্য মাছের বর্জ্য এবং নাইট্রেট উৎপাদন বৃদ্ধির দিকে পরিচালিত করে।' : 'Do not overfeed the fishes. Excess feed leads to more fish waste and increased nitrate production.'),
        (args['bangla'] ? 'জলের তাপমাত্রা' : 'Temperature'):(args['bangla'] ? 'জল বিনিময়ের মাধ্যমে, গ্রীষ্মের তাপীয় স্তরীকরণের সময় ছায়াময় গাছ লাগানো বা কৃত্রিম ছায়া তৈরি করা প্রতিরোধ করা যেতে পারে।' : 'By water exchange, planting shady trees or making artificial shades during summer’s thermal stratification can be prevented.'),
        (args['bangla'] ? 'দ্রবীভূত অক্সিজেন' : 'Dissolved Oxygen'):(args['bangla'] ? 'ডিও লেভেল বেশি হলে তা কমাতে পাইপ দিয়ে ধীরে ধীরে গরম পানি প্রবেশ করান।' : 'Introduction of the hot water gradually with pipes to reduce if DO level is high.'),
        (args['bangla'] ? 'জলের অস্বচ্ছতা' : 'Turbidity'):(args['bangla'] ? 'অধিক জল বা চুন (CaO, alum Al2(SO4)314H2O 20 mg L-1 হারে এবং সমগ্র পুকুরের জলে 200 Kg/ 1000m3 পুকুরের জলে জিপসাম ঢালাই কমাতে পারে।' : 'Addition of more water or lime (CaO, alum Al2(SO4)314H2O at a rate of 20 mg L-1 and gypsum on the entire pond water at rate of 200 Kg/ 1000m3 of pond can reduce turbidity')},
      {(args['bangla']?'মাছের বৃদ্ধির হার':'Fish Growth Rate'):(args['bangla'] ? 'মাছের বৃদ্ধির হার এত বেশি হতে পারে না। ডেটা ভুল।' : 'Fish growth can not be this high. Data is incorrect.'),
        (args['bangla'] ? 'মাছের দৈর্ঘ্য' : 'Fish Length'):(args['bangla'] ? 'মাছের দৈর্ঘ্য এত বেশি হতে পারে না। ডেটা ভুল।' : 'Fish length can not be this high. Data is incorrect.'),
        (args['bangla'] ? 'মাছের ওজন' : 'Fish Weight'):(args['bangla'] ? 'মাছের ওজন এত বেশি হতে পারে না। ডেটা ভুল।' : 'Fish weight can not be this high. Data is incorrect.')},
    ];
    var cnt=0;
    for(var j=0;j<water[i].length;j++){
      var tempval = (val[i][water[i][j]]?.data);
      var tempparam = whois[water[i][j]];
      var low = lower[tempparam];
      var up = upper[tempparam];
      if(tempval!<low!){
        cnt++;
        msg[i]=msg[i]+cnt.toString()+") "+if_low[i][water[i][j]]!+"\n\n";
      }
      else if(tempval>up!){
        cnt++;
        msg[i]=msg[i]+cnt.toString()+") "+if_high[i][water[i][j]]!+"\n\n";
      }
    }
    return Scaffold(
      backgroundColor: Color(0xFF99CDE3),
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
            children: <Widget>[
              Text(
                args['bangla']?'ড্যাশবোর্ড - পরামর্শ':'Dashboard - Suggestions',
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
                      height: 450,
                      child: SingleChildScrollView(
                        child: Text(
                          msg[i]!=''?msg[i]:(args['bangla']?'এখন জন্য কোন পরামর্শ নেই।':'There are no suggestions for now.'),
                          softWrap: true,
                        ),
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