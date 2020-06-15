import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:xpensy/Helpers/dbhelper.dart';
import 'package:xpensy/models/expenseModel.dart';
import 'package:xpensy/pages/homescreen.dart';

class Details extends StatelessWidget {
  final Expenses expenses;
  Details({this.expenses});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          AppBar(
            title: Text(expenses.desc),
            centerTitle: true,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20)),
              child: expenses.photoname == " "
                  ? Text("")
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.memory(
                        base64Decode(expenses.photoname),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                        height: MediaQuery.of(context).size.height / 5,
                        child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  "Amount",
                                  style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w300),
                                ),
                                Divider(
                                  color: Colors.grey[500],
                                ),
                                Text(
                                  expenses.amount,
                                  style: int.parse(expenses.amount) >= 1000
                                      ? TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.red)
                                      : TextStyle(
                                          fontSize: 20,
                                          color: Colors.green,
                                          fontWeight: FontWeight.w300),
                                ),
                              ],
                            ))))),
                Expanded(
                    child: Container(
                        height: MediaQuery.of(context).size.height / 5,
                        child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  "Date",
                                  style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w300),
                                ),
                                Divider(
                                  color: Colors.grey[500],
                                ),
                                Text(
                                  expenses.date,
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ))))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                        height: MediaQuery.of(context).size.height / 5,
                        child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Icon(
                                  Icons.mode_edit,
                                  color: Colors.green,
                                  size: 45,
                                ),
                                Divider(
                                  color: Colors.grey[500],
                                ),
                                Text("Ëdit",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.red)),
                              ],
                            ))))),
                Expanded(
                    child: GestureDetector(
                      onTap: ()
                      {
                        DBHelper.instance.delete(expenses.id);
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>HomeScreen()
                        ));
                      },
                  child: Container(
                      height: MediaQuery.of(context).size.height / 5,
                      child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                                size: 45,
                              ),
                              Divider(
                                color: Colors.grey[500],
                              ),
                              Text("Delete",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.red)),
                            ],
                          )))),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
