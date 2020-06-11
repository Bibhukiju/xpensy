import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:xpensy/Helpers/dbhelper.dart';
import 'package:xpensy/pages/homescreen.dart';

class AddExpenses extends StatefulWidget {
  @override
  _AddExpensesState createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  String _selecteddate;
  TextEditingController amount = TextEditingController();
  TextEditingController smallDesc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text("Add Expenses"),
      ),
      body: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  flex: 2,
                  child: Container(
                    color: Theme.of(context).primaryColor,
                  )),
              Expanded(
                  child: Container(
                color: Colors.white,
              )),
            ],
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Card(
                    elevation: 10,
                    color: Colors.white,
                    child: TextField(
                      controller: amount,
                      decoration: InputDecoration(
                        hintText: "Amount",
                      ),
                      keyboardType: TextInputType.number,
                    )),
                SizedBox(height: 20),
                Card(
                    elevation: 10,
                    color: Colors.white,
                    child: TextField(
                      controller: smallDesc,
                      maxLines: 7,
                      decoration: InputDecoration(
                          hintText: "Short Description",
                          prefixIcon: Icon(Icons.note)),
                    )),
                SizedBox(height: 20),
                Card(
                    elevation: 10,
                    color: Colors.white,
                    child: FlatButton(
                        onPressed: () {
                          DatePicker.showDateTimePicker(context,
                              onConfirm: (date) {
                            setState(() {
                              _selecteddate = date.toString().split(" ")[0];
                            });
                          }, currentTime: DateTime.now());
                        },
                        child: _selecteddate == null
                            ? Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.calendar_today,
                                    color: Colors.grey,
                                  ),
                                  Text(DateTime.now().toString().split(" ")[0]),
                                ],
                              )
                            : Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.calendar_today,
                                    color: Colors.deepPurple,
                                  ),
                                  Text("$_selecteddate"),
                                ],
                              )))
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          DBHelper.instance.insert({
            DBHelper.desc: smallDesc.text,
            DBHelper.cdate: DateTime.now().toString().split(" ")[0],
            DBHelper.amount: "100"
          });
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => HomeScreen()));
        },
      ),
    );
  }
}
