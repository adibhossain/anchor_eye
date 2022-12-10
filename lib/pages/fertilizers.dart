import 'package:flutter/material.dart';
import 'navbar.dart';

class Fertilizers extends StatefulWidget {
  @override
  _FertilizersState createState() => _FertilizersState();
}

class _FertilizersState extends State<Fertilizers> {
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
          args['bangla']?'ব্যবহৃত সার':'Used Fertilizers',
          style: TextStyle(
            fontSize: 30.0,
            color: Color(0xFFD2ECF2),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      key: _scaffoldKey, //this
      drawer: NavBar(bangla: args['bangla']),
      body: SafeArea(
        child: Center(
          child: Container(
            height: 430,
            child: Theme(
              data: Theme.of(context).copyWith(
                cardColor: Color(0xFFF0E8EA),
                dividerColor: Color(0xFFB9E6FA),
              ),
              child: PaginatedDataTable(
                //sortColumnIndex: 1,
                header: Center(
                  child: Text(
                    (args['bangla']?'তারিখ: ':'Date: ')+args['date'],
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Color(0xFF0A457C),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                columns: <DataColumn>[
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        args['bangla']?'ক্রমিক নং,':'Sl no.',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Color(0xFF0A457C),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        args['bangla']?'সারের নাম':'Fertilizer Name',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Color(0xFF0A457C),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        args['bangla']?'সারের\nপরিমাণ(গ্রাম)':'Fertilizer\nAmount(gm)',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Color(0xFF0A457C),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
                source: MyData(args['data']),
                columnSpacing: 55,
                horizontalMargin: 10,
                rowsPerPage: 5,
                showCheckboxColumn: false,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyData extends DataTableSource {
  MyData(dynamic this.data);
  dynamic data;
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
                (index+1).toString(),
                style: TextStyle(
                  fontSize: 15.0,
                  //color: Color(0xFFD2ECF2),
                  //fontWeight: FontWeight.bold,
                ),
              ),
            )
        ),
        DataCell(
            Center(
              child: Text(
                data[index].name,
                style: TextStyle(
                  fontSize: 15.0,
                  //color: Color(0xFFD2ECF2),
                  //fontWeight: FontWeight.bold,
                ),
              ),
            )
        ),
        DataCell(
            Center(
              child: Text(
                data[index].amount.toString(),
                style: TextStyle(
                  fontSize: 15.0,
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