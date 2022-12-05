import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Syncfusion Flutter chart'),
        ),
        body: Center(
    child: Card(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const ListTile(
          leading: Icon(Icons.album),
          title: Text('The Enchanted Nightingale'),
          subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TextButton(
              child: const Text('BUY TICKETS'),
              onPressed: () {/* ... */},
            ),
            const SizedBox(width: 8),
            TextButton(
              child: const Text('LISTEN'),
              onPressed: () {/* ... */},
            ),
            const SizedBox(width: 8),
          ],
        ),
        SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            // Chart title
            title: ChartTitle(text: 'pH Report'),
            // Enable legend
            legend: Legend(isVisible: true),
            // Enable tooltip
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries<_SalesData, String>>[
              LineSeries<_SalesData, String>(
                  dataSource: data,
                  xValueMapper: (_SalesData sales, _) => sales.year,
                  yValueMapper: (_SalesData sales, _) => sales.sales,
                  name: 'Received Data',
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
      ],
    ),
    ),
    )
    );
  }
}
class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}