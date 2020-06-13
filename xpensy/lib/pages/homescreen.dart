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
  bool pressed = false;
  var total = 0;

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
    void gettotal() async {
      for (var i = 0; i < expernse.length; i++) {
        setState(() {
          total += int.parse(expernse.elementAt(i).amount);
        });
      }
    }

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
            Positioned(
              left: 15,
              top: 10,
              child: Text(
                "All Records",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
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
            expernse == null
                ? Container()
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
                    child: ListView.builder(
                        itemCount: expernse.length,
                        itemBuilder: (BuildContext context, int index) =>
                            Container(
                                child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: ListTile(
                                contentPadding: EdgeInsets.all(10),
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.height /
                                              20,
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      child: Icon(
                                        Icons.image,
                                        size:
                                            MediaQuery.of(context).size.height /
                                                20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            expernse.elementAt(index).desc,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20),
                                          ),
                                          Text(expernse.elementAt(index).amount)
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: <Widget>[
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              expernse.removeAt(index);
                                            });
                                            DBHelper.instance.deletee(
                                                expernse.elementAt(index).id);
                                          },
                                          icon: Icon(
                                            Icons.delete_outline,
                                            size: 30,
                                          ),
                                          color: Colors.red,
                                        ),
                                        Text(
                                          expernse.elementAt(index).date,
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                subtitle: Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          1.6,
                                    ),
                                  ],
                                ),
                              ),
                            ))),
                  ),
            Positioned(
              bottom: MediaQuery.of(context).size.height / 10,
              right: 10,
              child: Card(
                child: GestureDetector(
                  onTap: () {
                    if (!pressed) {
                      gettotal();
                      print(total);
                      setState(() {
                        pressed = true;
                      });
                    } else {
                      setState(() {
                        pressed = false;
                        total = -total;
                      });
                      gettotal();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      !pressed ? "Get Total" : "Total: " + total.toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
