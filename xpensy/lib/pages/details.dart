import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/expenseModel.dart';

class Details extends StatelessWidget {
  final Expenses expenses;
  Details({this.expenses});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(expenses.desc),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height / 2,
                child: expenses.photoname != " "
                    ? Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        color: Colors.grey[300],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.memory(
                            base64Decode(expenses.photoname),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height / 2,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          color: Colors.grey[300],
                          child: Center(
                              child: Flexible(
                            child: Text(
                              "No Attachments",
                              style: TextStyle(fontSize: 30),
                            ),
                          )),
                        ),
                      )),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 5,
                    child: Card(
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text("Amount",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600)),
                          int.parse(expenses.amount) <= 1000
                              ? Text(expenses.amount,
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600))
                              : Text(expenses.amount,
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600)),
                        ],
                      )),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 5,
                    child: Card(
                      child: Center(child: Text("Date: " + expenses.date)),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
