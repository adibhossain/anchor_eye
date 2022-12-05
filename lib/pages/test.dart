import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'navbar.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  List<_SalesData> data = [
    _SalesData('Jan', 6.9),
    _SalesData('Feb', 8.9),
    _SalesData('Mar', 8.0),
    _SalesData('Apr', 7.7),
    _SalesData('May', 5.5)
  ];
  List<_SalesData> ideal = [
    _SalesData('Jan', 7.7),
    _SalesData('Feb', 7.9),
    _SalesData('Mar', 7.8),
    _SalesData('Apr', 8.1),
    _SalesData('May', 9.1)
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); //this
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFB9E6FA),
      appBar: AppBar( //this
        backgroundColor: Color(0xFF186B9A),
        centerTitle: true,
        title: Text(
          'বিস্তারিত রিপোর্ট',
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
            Text(
              'পিএইচ (pH)',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Table(
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
                        'তারিখ',
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
                        'বর্তমান',
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
                        'আদর্শ',
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
            ),
            SizedBox(height: 20.0),
            Container(
              //margin: EdgeInsets.symmetric(vertical: 0,horizontal: 60),
              padding: EdgeInsets.symmetric(vertical: 0,horizontal: 55),
              child: SfCartesianChart(
                  backgroundColor: Color(0xFFF0E8EA),
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(
                    maximum: 14.0,
                    minimum: 0.0,
                  ),
                  // Chart title
                  title: ChartTitle(text: 'পিএইচ (pH) রিপোর্ট'),
                  // Enable legend
                  legend: Legend(isVisible: true),
                  // Enable tooltip
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<_SalesData, String>>[
                    LineSeries<_SalesData, String>(
                        dataSource: data,
                        xValueMapper: (_SalesData sales, _) => sales.year,
                        yValueMapper: (_SalesData sales, _) => sales.sales,
                        name: 'প্রাপ্ত তথ্য',
                        // Enable data label
                        dataLabelSettings: DataLabelSettings(isVisible: false)),
                    LineSeries<_SalesData, String>(
                        dataSource: ideal,
                        xValueMapper: (_SalesData sales, _) => sales.year,
                        yValueMapper: (_SalesData sales, _) => sales.sales,
                        name: 'Ideal Value',
                        // Enable data label
                        dataLabelSettings: DataLabelSettings(isVisible: false)),
                  ]),
            ),
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