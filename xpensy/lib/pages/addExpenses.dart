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
  String dropDownValue = "Miscellaneous";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text("Add Expenses"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          _buildBackground(context),
          Container(
            margin: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.white,
                      child: TextField(
                        controller: amount,
                        decoration: InputDecoration(
                            hintText: "  Amount",
                            prefixText: "Rs: ",
                            prefixStyle: TextStyle(
                              color: Colors.red[500],
                              fontSize: 20,
                            ),
                            contentPadding: EdgeInsets.all(20)),
                        keyboardType: TextInputType.number,
                      )),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 10,
                      color: Colors.white,
                      child: TextField(
                        controller: smallDesc,
                        maxLines: 7,
                        decoration: InputDecoration(
                          hintText: "Short Description",
                          contentPadding: EdgeInsets.all(20),
                          prefixIcon: Icon(
                            Icons.note,
                            color: Colors.red,
                          ),
                        ),
                      )),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 10,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: FlatButton(
                            onPressed: () {
                              DatePicker.showDateTimePicker(context,
                                  onConfirm: (date) {
                                setState(() {
                                  _selecteddate =
                                      date.toString().split(" ")[0];
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
                                      SizedBox(
                                        width: MediaQuery.of(context)
                                                .size
                                                .width /
                                            20,
                                      ),
                                      Text(DateTime.now()
                                          .toString()
                                          .split(" ")[0]),
                                    ],
                                  )
                                : Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.calendar_today,
                                        color: Colors.red,
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context)
                                                .size
                                                .width /
                                            20,
                                      ),
                                      Text("$_selecteddate"),
                                    ],
                                  )),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          "Category",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.red),
                        ),
                        DropdownButton<String>(
                          value: dropDownValue,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 0,
                          underline: Text(""),
                          onChanged: (String newValue) {
                            setState(() {
                              dropDownValue = newValue;
                            });
                          },
                          items: <String>[
                            'Miscellaneous',
                            'Fooding',
                            'Clothing',
                            'Hygiene',
                            'Stationery'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
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
            DBHelper.amount: amount.text,
            DBHelper.photoname: " ",
            DBHelper.category: dropDownValue
          });
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => HomeScreen()));
        },
      ),
    );
  }

  Row _buildBackground(BuildContext context) {
    return Row(
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
    );
  }
}
