import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'navbar.dart';

class DashDetail extends StatefulWidget {
  @override
  _DashDetailState createState() => _DashDetailState();
}

class _DashDetailState extends State<DashDetail> {
  Map args = {};
  List<_SalesData> data = [
    _SalesData('Jan', 6.9),
    _SalesData('Feb', 8.9),
    _SalesData('Mar', 8.0),
    _SalesData('Apr', 7.7),
    _SalesData('May', 5.5),
    _SalesData('Jun', 5.8),
    _SalesData('Jul', 4.5),
    _SalesData('Aug', 8.3),
    _SalesData('Sep', 8.9),
    _SalesData('Oct', 7.8),
    _SalesData('Nov', 2.3),
    _SalesData('Dec', 5.6),
  ];
  List<_SalesData> ideal = [
    _SalesData('Jan', 7.7),
    _SalesData('Feb', 7.9),
    _SalesData('Mar', 7.8),
    _SalesData('Apr', 8.1),
    _SalesData('May', 9.1),
    _SalesData('Jun', 6.8),
    _SalesData('Jul', 5.5),
    _SalesData('Aug', 6.3),
    _SalesData('Sep', 6.9),
    _SalesData('Oct', 7.8),
    _SalesData('Nov', 6.3),
    _SalesData('Dec', 7.6),
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); //this
  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)?.settings.arguments as Map;
    return Scaffold(
        backgroundColor: Color(0xFFB9E6FA),
      appBar: AppBar( //this
        backgroundColor: Color(0xFF186B9A),
        centerTitle: true,
        title: Text(
          args['bangla']?'বিস্তারিত রিপোর্ট':'Detailed Report',
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
            Container(
              //margin: EdgeInsets.symmetric(vertical: 0,horizontal: 60),
              padding: EdgeInsets.symmetric(vertical: 40,horizontal: 55),
              child: SfCartesianChart(
                  backgroundColor: Color(0xFFF0E8EA),
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(
                    maximum: 14.0,
                    minimum: 0.0,
                  ),
                  // Chart title
                  title: ChartTitle(text: args['bangla']?'পিএইচ (pH) রিপোর্ট':'pH Report'),
                  // Enable legend
                  legend: Legend(isVisible: true),
                  // Enable tooltip
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<_SalesData, String>>[
                    LineSeries<_SalesData, String>(
                        dataSource: data,
                        xValueMapper: (_SalesData sales, _) => sales.year,
                        yValueMapper: (_SalesData sales, _) => sales.sales,
                        name: args['bangla']?'বর্তমান':'Current',
                        // Enable data label
                        dataLabelSettings: DataLabelSettings(isVisible: false)),
                    LineSeries<_SalesData, String>(
                        dataSource: ideal,
                        xValueMapper: (_SalesData sales, _) => sales.year,
                        yValueMapper: (_SalesData sales, _) => sales.sales,
                        name: args['bangla']?'আদর্শ':'Ideal',
                        // Enable data label
                        dataLabelSettings: DataLabelSettings(isVisible: false)),
                  ]),
            ),
            Text(
              args['bangla']?'পিএইচ (pH) ট্যাবুলার ডেটা':'pH Tabular Data',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: SizedBox(
                height: 200,
                width: 300,
                child: ListView(
                  children: <Widget>[Table(
                    border: TableBorder.all(),
                    columnWidths: const <int, TableColumnWidth>{
                      0: FixedColumnWidth(100),
                      1: FixedColumnWidth(100),
                      2: FixedColumnWidth(100),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: <TableRow>[
                      TableRow(
                        decoration: const BoxDecoration(
                          color: Color(0xFF1871A3),
                        ),
                        children: <Widget>[
                          Container(
                            //height: 32,
                            child: Center(child:Text(
                              args['bangla']?'তারিখ':'Date',
                              style: TextStyle(
                                fontSize: 20.0,
                                //color: Color(0xFFD2ECF2),
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                          ),
                          Container(
                            //height: 32,
                            child: Center(child:Text(
                              args['bangla']?'বর্তমান':'Current',
                              style: TextStyle(
                                fontSize: 20.0,
                                //color: Color(0xFFD2ECF2),
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                          ),
                          Container(
                            //height: 32,
                            child: Center(child:Text(
                              args['bangla']?'আদর্শ':'Ideal',
                              style: TextStyle(
                                fontSize: 20.0,
                                //color: Color(0xFFD2ECF2),
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                          ),
                        ],
                      )]+
                      data.map((datax){
                        return TableRow(
                          children: <Widget>[
                            Container(
                              //height: 32,
                              child: Center(child:Text(
                                datax.year.toString(),
                                style: TextStyle(
                                  fontSize: 20.0,
                                  //color: Color(0xFFD2ECF2),
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                            ),
                            Container(
                              //height: 32,
                              child: Center(child:Text(
                                datax.sales.toString(),
                                style: TextStyle(
                                  fontSize: 20.0,
                                  //color: Color(0xFFD2ECF2),
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                            ),
                            Container(
                              //height: 32,
                              child: Center(child:Text(
                                ideal[data.indexOf(datax)].sales.toString(),
                                style: TextStyle(
                                  fontSize: 20.0,
                                  //color: Color(0xFFD2ECF2),
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                            ),
                          ],
                        );
                      }).toList(),
                  )]
                ),
              ),
            ),
            SizedBox(height: 40.0),
          ],
        ),
    );
  }
}
class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}