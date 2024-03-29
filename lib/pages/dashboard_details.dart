import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'navbar.dart';

class DashDetail extends StatefulWidget {
  @override
  _DashDetailState createState() => _DashDetailState();
}

class _DashDetailState extends State<DashDetail> {
  Map args = {};
  var dropDownmonth = '';
  var dropDownseason = '';
  var prediction = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // this
  bool loading = true,filtering=false;

  List<_SalesData> Data = [];
  List<_SalesData> Data2 = [];
  List<_SalesData> Upper = [];
  List<_SalesData> Lower = [];
  var mn = 0.0;
  var mx = 0.0;

  var params;

  Future loadData() async{
    if(!loading){
      if(filtering){
        filtering=false;
        Data2.clear();
        for(var snap in params){
          var month = await snap.get('month');
          var season = await snap.get('season');
          if(dropDownmonth!='' && dropDownmonth!=month) continue;
          if(dropDownseason!='' && dropDownseason!=season) continue;
          var val2 = await snap.get(args['param']);
          Data2.add(_SalesData(snap.id, double.parse(val2)));
        }
      }
      return;
    }
    mn = args['lower'][args['param']];
    mx = args['upper'][args['param']];
     await args['farm_data'].reference.collection('params').get().then((docsnap){
      params = docsnap.docs;
    });
    for(var snap in params){
      var fetch = await snap.get(args['param']);
      double val = double.parse(fetch);
      mn=min(mn,val);
      mx=max(mx,val);
      Data.add(_SalesData(snap.id, val));
      Data2.add(_SalesData(snap.id, val));
      Lower.add(_SalesData(snap.id, args['lower'][args['param']]!));
      Upper.add(_SalesData(snap.id, args['upper'][args['param']]!));
    }
    loading = false;
    return;
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)?.settings.arguments as Map;
    List<String> months = args['bangla']?
    <String>['','জানুয়ারী', 'ফেব্রুয়ারী', 'মার্চ', 'এপ্রিল', 'মে', 'জুন', 'জুলাই', 'আগস্ট', 'সেপ্টেম্বর', 'অক্টোবর', 'নভেম্বর', 'ডিসেম্বর']:
    <String>['','January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    List<String> seasons = args['bangla']?
    <String>['','শীত', 'গ্রীষ্ম', 'বর্ষা']:
    <String>['','Winter', 'Summer', 'Rainy'];
    return Scaffold(
        backgroundColor: Color(0xFFB9E6FA),
        appBar: AppBar( //this
          backgroundColor: Color(0xFF186B9A),
          centerTitle: true,
          title: Text(
            args['title'],
            style: TextStyle(
              fontSize: 30.0,
              color: Color(0xFFD2ECF2),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        key: _scaffoldKey, //this
        drawer: NavBar(bangla: args['bangla']),
        body: FutureBuilder(
          future: loadData(),
          builder: (context, snapshot){
            if((!loading && !filtering) || snapshot.connectionState == ConnectionState.done){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    //margin: EdgeInsets.symmetric(vertical: 0,horizontal: 60),
                    padding: EdgeInsets.symmetric(vertical: 15,horizontal: 35),
                    height: 320,
                    child: SfCartesianChart(
                        backgroundColor: Color(0xFFF0E8EA),
                        primaryXAxis: CategoryAxis(),
                        primaryYAxis: NumericAxis(
                          maximum: mx+1,
                          minimum: mn-1<0?0:mn-1,
                        ),
                        // Chart title
                        title: ChartTitle(
                          text: args['bangla']?'গ্রাফ রিপোর্ট':'Graph Report',
                          textStyle: TextStyle(
                            fontSize: 20.0,
                            color: Color(0xFF0A457C),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Enable legend
                        legend: Legend(
                          isVisible: true,
                          toggleSeriesVisibility: true,
                          position: LegendPosition.right,
                        ),
                        // Enable tooltip
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <ChartSeries<_SalesData, String>>[
                          LineSeries<_SalesData, String>(
                              dataSource: Data,
                              xValueMapper: (_SalesData sales, _) => sales.year,
                              yValueMapper: (_SalesData sales, _) => sales.sales,
                              name: args['bangla']?'প্রাপ্ত মান':'Received Value',
                              // Enable data label
                              dataLabelSettings: DataLabelSettings(isVisible: false)),
                          LineSeries<_SalesData, String>(
                              dataSource: Lower,
                              xValueMapper: (_SalesData sales, _) => sales.year,
                              yValueMapper: (_SalesData sales, _) => sales.sales,
                              name: (args['bangla']?'নিম্ন আদর্শ মান':'Lower Ideal Value\n = ')+(args['lower'][args['param']]).toString(),
                              // Enable data label
                              dataLabelSettings: DataLabelSettings(isVisible: false)),
                          LineSeries<_SalesData, String>(
                              color: Colors.orange,
                              dataSource: Upper,
                              xValueMapper: (_SalesData sales, _) => sales.year,
                              yValueMapper: (_SalesData sales, _) => sales.sales,
                              name: (args['bangla']?'উচ্চ আদর্শ মান':'Upper Ideal Value\n = ')+(args['upper'][args['param']]).toString(),
                              // Enable data label
                              dataLabelSettings: DataLabelSettings(isVisible: false)),
                        ]),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5,horizontal: 0),
                    color: Color(0xFFF0E8EA),
                    width: 310,
                    child: Center(
                      child: Text(
                        args['bangla']?'ট্যাবুলার ডেটা':'Tabular Data',
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Color(0xFF0A457C),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 200,
                      width: 320,
                      child: ListView(
                          children: <Widget>[
                            Theme(
                              data: Theme.of(context).copyWith(
                                  cardColor: Color(0xFFF0E8EA),
                                  dividerColor: Color(0xFFB9E6FA)
                              ),
                              child: PaginatedDataTable(
                                onPageChanged: (value){
                                  //prediction = (value>=_alldata.data.length);
                                  //setState(() {});
                                },
                                //sortColumnIndex: 1,
                                header: Center(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          args['bangla']?'ফিল্টার':'Filter By',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: Color(0xFF0A457C),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Row(
                                          children: [
                                            Text(
                                              args['bangla']?'মাস অনুযায়ী - ':'Month - ',
                                              style: TextStyle(
                                                fontSize: 10.0,
                                                color: Color(0xFF0A457C),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            DropdownButton<String>(
                                              value: dropDownmonth,
                                              icon: const Icon(Icons.arrow_drop_down),
                                              elevation: 16,
                                              style: TextStyle(
                                                fontSize: 10.0,
                                                color: Color(0xFF0A457C),
                                                fontWeight: FontWeight.bold,
                                              ),
                                              underline: Container(
                                                height: 2,
                                                color: Color(0xFF0A457C),
                                              ),
                                              onChanged: (String? value) {
                                                // This is called when the user selects an item.
                                                dropDownmonth = value!;
                                                filtering=true;
                                                setState(() {});
                                                //print(dropDownmonth);
                                                //print(dropDownseason);
                                              },
                                              items: months.map<DropdownMenuItem<String>>((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    style: TextStyle(
                                                      fontSize: 10.0,
                                                      color: Color(0xFF0A457C),
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              args['bangla']?'ঋতু অনুসারে - ':'Season - ',
                                              style: TextStyle(
                                                fontSize: 10.0,
                                                color: Color(0xFF0A457C),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            DropdownButton<String>(
                                              value: dropDownseason,
                                              icon: const Icon(Icons.arrow_drop_down),
                                              elevation: 16,
                                              style: TextStyle(
                                                fontSize: 10.0,
                                                color: Color(0xFF0A457C),
                                                fontWeight: FontWeight.bold,
                                              ),
                                              underline: Container(
                                                height: 2,
                                                color: Color(0xFF0A457C),
                                              ),
                                              onChanged: (String? value) {
                                                // This is called when the user selects an item.
                                                dropDownseason = value!;
                                                filtering=true;
                                                setState(() {});
                                                //print(dropDownmonth=='');
                                                //print(dropDownseason=='');
                                              },
                                              items: seasons.map<DropdownMenuItem<String>>((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    style: TextStyle(
                                                      fontSize: 10.0,
                                                      color: Color(0xFF0A457C),
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                columns: <DataColumn>[
                                  DataColumn(
                                    label: Expanded(
                                      child: Center(
                                        child: Text(
                                          args['bangla']?'তারিখ':'Date',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: Color(0xFF0A457C),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Expanded(
                                      child: Center(
                                        child: Text(
                                          args['bangla']?'প্রাপ্ত':'Received',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: Color(0xFF0A457C),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                                source: MyData(Data2,Lower,Upper),
                                columnSpacing: 30,
                                horizontalMargin: 10,
                                rowsPerPage: 3,
                                showCheckboxColumn: false,
                              ),
                            ),
                          ]
                      ),
                    ),
                  ),
                  SizedBox(height: 40.0),
                ],
              );
            }
            else{
              return Container(
                child: SpinKitRing(
                  color: Color(0xFF0A457C),
                  size: 50.0,
                ),
              );
            }
          },
        ),
    );
  }
}
class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

class MyData extends DataTableSource {
  MyData(this.data,this.lower,this.upper);
  List<_SalesData> data = [];
  List<_SalesData> lower = [];
  List<_SalesData> upper = [];
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
                data[index].year.toString(),
                style: TextStyle(
                  fontSize: 20.0,
                  //color: Color(0xFFD2ECF2),
                  //fontWeight: FontWeight.bold,
                ),
              ),
            )
        ),
        DataCell(
            Center(
              child: Text(
                data[index].sales.toString(),
                style: TextStyle(
                  fontSize: 20.0,
                  //color: Color(0xFFD2ECF2),
                  //fontWeight: FontWeight.bold,
                ),
              ),
            )
        ),
      ],
    );
  }
}