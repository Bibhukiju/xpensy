import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:xpensy/models/expenseModel.dart';
import 'dbhelper.dart';

/// Data class to visualize.
class _CostsData {
  final String category;
  final int cost;

  const _CostsData(this.category, this.cost);
}

class PieCharted extends StatefulWidget {
  const PieCharted({Key key}) : super(key: key);

  @override
  _PieChartedState createState() => _PieChartedState();
}

class _PieChartedState extends State<PieCharted> {
  int micell = 0;
  int fooding = 0;
  int clothing = 0;
  int hygiene = 0;
  int stationery = 0;

  List<Expenses> expernse;
  myQuery() async {
    Future<List> _futureList = DBHelper.instance.getExpendedList();
    List<Expenses> listexp = await _futureList;
    setState(() {
      expernse = listexp;
    });
    for (var v in expernse) {
      if (v.catergory == "Miscellaneous") {
        micell += int.parse(v.amount);
      }
      if (v.catergory == "Fooding") {
        fooding += int.parse(v.amount);
      }
      if (v.catergory == "Clothing") {
        clothing += int.parse(v.amount);
      }
      if (v.catergory == "Hygiene") {
        hygiene += int.parse(v.amount);
      }
      if (v.catergory == "Stationery") {
        stationery += int.parse(v.amount);
      }
    }
  }

  @override
  void initState() {
    myQuery();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<_CostsData> _data = [
      _CostsData('Miscellaneous', micell),
      _CostsData('Fooding', fooding),
      _CostsData('Clothing', clothing),
      _CostsData('Hygiene', hygiene),
      _CostsData('Stationery', stationery)
    ];
    final _colorPalettes =
        charts.MaterialPalette.getOrderedPalettes(_data.length);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Center(child: Text("Pie Chart of Total Expenses")),
            SizedBox(
              height: MediaQuery.of(context).size.height / 8,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              child: charts.PieChart(
                // Pie chart can only render one series.
                /*seriesList=*/ [
                  charts.Series<_CostsData, String>(
                    id: 'Datas',
                    colorFn: (_, idx) => _colorPalettes[idx].shadeDefault,
                    domainFn: (_CostsData sales, _) => sales.category,
                    measureFn: (_CostsData sales, _) => sales.cost,
                    data: _data,
                    // Set a label accessor to control the text of the arc label.
                    labelAccessorFn: (_CostsData row, _) =>
                        '${row.category}: ${row.cost}',
                  ),
                ],
                animate: true,
                defaultRenderer: new charts.ArcRendererConfig(
                  arcRatio: 0.5,
                  arcRendererDecorators: [charts.ArcLabelDecorator()],
                ),
                behaviors: [
                  // Add title.
                  charts.ChartTitle('expenses',
                      behaviorPosition: charts.BehaviorPosition.top),
                  // Add legend. ("Datum" means the "X-axis" of each data point.)
                  charts.DatumLegend(position: charts.BehaviorPosition.start),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 4,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      buildRow("Fooding", fooding),
                      buildRow("Hygiene", hygiene),
                      buildRow("Clothing", clothing),
                      buildRow("Stationery", stationery),
                      buildRow("Micellaneous", micell)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Row buildRow(String cat, int cost) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(cat),
        SizedBox(
          width: MediaQuery.of(context).size.width / 5,
        ),
        Text(cost.toString())
      ],
    );
  }
}
