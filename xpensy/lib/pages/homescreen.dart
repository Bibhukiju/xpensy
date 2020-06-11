import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:xpensy/Helpers/dbhelper.dart';
import 'package:xpensy/models/expenseModel.dart';
import 'package:xpensy/pages/addExpenses.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _selecteddate;
  var sdate;
  List<Expenses> expernse;
  myQuery() async {
    Future<List> _futureList = DBHelper.instance.getExpendedList();
    List<Expenses> listexp = await _futureList;
    setState(() {
      expernse = listexp;
    });
  }

  @override
  void initState() {
    super.initState();
    myQuery();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  flex: 14,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.image),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    AddExpenses()));
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.camera),
                          color: Theme.of(context).primaryColor,
                          onPressed: () async {
                            List<Map<String, dynamic>> queryRows =
                                await DBHelper.instance.queryAll();
                            print(queryRows);
                          },
                        ),
                        Icon(
                          Icons.not_interested,
                          color: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Text(
              "All Records",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w400),
            ),
            Positioned(
                right: 10,
                top: 20,
                child: FlatButton(
                    onPressed: () {
                      DatePicker.showDateTimePicker(context, onConfirm: (date) {
                        setState(() {
                          sdate = date;
                          _selecteddate = sdate.toString().split(" ")[0];
                        });
                      }, currentTime: sdate);
                    },
                    child: _selecteddate == null
                        ? Icon(Icons.calendar_today)
                        : Text("$_selecteddate"))),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
                child: ListView.builder(
                    itemCount: expernse.length,
                    itemBuilder: (BuildContext context, int index) => Container(
                          height: MediaQuery.of(context).size.height / 6,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                child: Card(
                                  child: Positioned(
                                    right: 10,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Text(
                                          expernse.elementAt(index).desc,
                                          style: TextStyle(
                                              fontSize: 32,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          expernse.elementAt(index).amount,
                                          style:TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 20,
                                top: 30,
                                child: CircleAvatar(
                                    radius:
                                        MediaQuery.of(context).size.height / 20,
                                    child: Icon(Icons.not_interested)),
                              ),
                            ],
                          ),
                        ))),
          ],
        ),
      ),
    );
  }
}
