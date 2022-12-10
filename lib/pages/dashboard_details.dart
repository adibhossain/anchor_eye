import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'navbar.dart';

class DashDetail extends StatefulWidget {
  @override
  _DashDetailState createState() => _DashDetailState();
}

class _DashDetailState extends State<DashDetail> {
  Map args = {};
  MyData _alldata = MyData();
  var dropDownmonth = '';
  var dropDownseason = '';
  var prediction = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); //this
  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)?.settings.arguments as Map;
    var data = _alldata.data+[_alldata.predicted.first];
    var ideal = _alldata.ideal+[_alldata.suggested.first];
    var predicted = _alldata.predicted;
    var suggested = _alldata.suggested;
    List<String> months = args['bangla']?
    <String>['','জানুয়ারী', 'ফেব্রুয়ারী', 'মার্চ', 'এপ্রিল', 'মে', 'জুন', 'জুলাই', 'আগস্ট', 'সেপ্টেম্বর', 'অক্টোবর', 'নভেম্বর', 'ডিসেম্বর']:
    <String>['','January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    List<String> seasons = args['bangla']?
    <String>['','শীত', 'গ্রীষ্ম', 'শরৎ']:
    <String>['','Winter', 'Summer', 'Autumn'];
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
              padding: EdgeInsets.symmetric(vertical: 15,horizontal: 35),
              height: 320,
              child: SfCartesianChart(
                  backgroundColor: Color(0xFFF0E8EA),
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(
                    maximum: 14.0,
                    minimum: 0.0,
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
                        dataSource: data,
                        xValueMapper: (_SalesData sales, _) => sales.year,
                        yValueMapper: (_SalesData sales, _) => sales.sales,
                        name: args['bangla']?'প্রাপ্ত মান':'Received Value',
                        // Enable data label
                        dataLabelSettings: DataLabelSettings(isVisible: false)),
                    LineSeries<_SalesData, String>(
                        dataSource: ideal,
                        xValueMapper: (_SalesData sales, _) => sales.year,
                        yValueMapper: (_SalesData sales, _) => sales.sales,
                        name: args['bangla']?'আদর্শ মান':'Ideal Value',
                        // Enable data label
                        dataLabelSettings: DataLabelSettings(isVisible: false)),
                    LineSeries<_SalesData, String>(
                        color: Colors.blue,
                        dashArray: <double>[5,5],
                        dataSource: predicted,
                        xValueMapper: (_SalesData sales, _) => sales.year,
                        yValueMapper: (_SalesData sales, _) => sales.sales,
                        name: args['bangla']?'পূর্বাভাস':'Prediction',
                        // Enable data label
                        dataLabelSettings: DataLabelSettings(isVisible: false)),
                    LineSeries<_SalesData, String>(
                        color: Colors.red,
                        dashArray: <double>[5,5],
                        dataSource: suggested,
                        xValueMapper: (_SalesData sales, _) => sales.year,
                        yValueMapper: (_SalesData sales, _) => sales.sales,
                        name: args['bangla']?'পরামর্শ':'Suggestion',
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
                          prediction = (value>=_alldata.data.length);
                          setState(() {});
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
                                          setState(() {
                                            dropDownmonth = value!;
                                          });
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
                                          setState(() {
                                            dropDownseason = value!;
                                          });
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
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  !prediction?
                                  (args['bangla']?'প্রাপ্ত':'Current'):
                                  (args['bangla']?'পূর্বাভাস':'Predicted'),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Color(0xFF0A457C),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  !prediction?
                                  (args['bangla']?'আদর্শ':'Ideal'):
                                  (args['bangla']?'পরামর্শ':'Suggested'),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Color(0xFF0A457C),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                          source: MyData(),
                          columnSpacing: 20,
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
  // Generate some made-up data
  List<_SalesData> data = [
    _SalesData('09/01/2022', 6.9),
    _SalesData('10/02/2022', 8.9),
    _SalesData('07/03/2022', 8.0),
    _SalesData('05/04/2022', 7.7),
    _SalesData('12/05/2022', 5.5),
    _SalesData('19/06/2022', 5.8),
  ];
  List<_SalesData> predicted = [
    _SalesData('08/07/2022', 4.5),
    _SalesData('09/08/2022', 8.3),
    _SalesData('11/09/2022', 8.9),
    _SalesData('02/10/2022', 7.8),
    _SalesData('15/11/2022', 2.3),
    _SalesData('13/12/2022', 5.6),
  ];
  List<_SalesData> ideal = [
    _SalesData('09/01/2022', 7.7),
    _SalesData('10/02/2022', 7.9),
    _SalesData('07/03/2022', 7.8),
    _SalesData('05/04/2022', 8.1),
    _SalesData('12/05/2022', 9.1),
    _SalesData('19/06/2022', 6.8),
  ];
  List<_SalesData> suggested = [
    _SalesData('08/07/2022', 5.5),
    _SalesData('09/08/2022', 6.3),
    _SalesData('11/09/2022', 6.9),
    _SalesData('02/10/2022', 7.8),
    _SalesData('15/11/2022', 6.3),
    _SalesData('13/12/2022', 7.6),
  ];
  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => data.length+predicted.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    return DataRow(
      cells: <DataCell>[
        DataCell(
            Text(
              (index<data.length?data[index]:predicted[index-data.length]).year.toString(),
              style: TextStyle(
                fontSize: 20.0,
                //color: Color(0xFFD2ECF2),
                //fontWeight: FontWeight.bold,
              ),
            )
        ),
        DataCell(
            Text(
              (index<data.length?data[index]:predicted[index-data.length]).sales.toString(),
              style: TextStyle(
                fontSize: 20.0,
                //color: Color(0xFFD2ECF2),
                //fontWeight: FontWeight.bold,
              ),
            )
        ),
        DataCell(
            Text(
              (index<data.length?ideal[index]:suggested[index-data.length]).sales.toString(),
              style: TextStyle(
                fontSize: 20.0,
                //color: Color(0xFFD2ECF2),
                //fontWeight: FontWeight.bold,
              ),
            )
        ),
      ],
    );
  }
}