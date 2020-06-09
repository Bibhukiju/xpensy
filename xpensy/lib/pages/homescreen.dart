import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutterapp/models/expensesModel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ExModel> expenses = [
    ExModel(
        amount: "100",
        dateTime: DateTime.now(),
        title: "Hello",
        imgUrl: "https://i.ytimg.com/vi/7tdUCk9pLPw/maxresdefault.jpg"),
    ExModel(
        amount: "200",
        dateTime: DateTime.now(),
        title: "Chowmein",
        imgUrl:
            "https://c.ndtvimg.com/mnng9ei8_chowmein_640x480_25_July_18.jpg")
  ];
  var _selecteddate;
  var sdate;
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
                        child: Container(color: Colors.white),
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
                        Icon(
                          Icons.image,
                          color: Theme.of(context).primaryColor,
                        ),
                        Icon(
                          Icons.camera,
                          color: Theme.of(context).primaryColor,
                          size: 50,
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
                height: 300,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
                child: ListView.builder(
                  itemCount: expenses.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: MediaQuery.of(context).size.height / 7,
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            CircleAvatar(
                              radius: MediaQuery.of(context).size.height / 15,
                              backgroundImage: NetworkImage(
                                  expenses.elementAt(index).imgUrl),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(expenses.elementAt(index).title,
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    )),
                                Text(expenses.elementAt(index).amount,
                                    style: TextStyle(
                                      fontSize: 20,
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ))
          ],
        ),
      ),
    );
  }
}
