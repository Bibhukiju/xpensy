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
                        child: Image.memory(base64Decode(expenses.photoname)),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height / 2,
                        child: Card(
                          elevation: 10,
                          child: Center(
                              child: Flexible(
                            child: Text(
                              "No Attachments",
                              style: TextStyle(fontSize: 30),
                            ),
                          )),
                        ),
                      )),
            Container(
              child: Text(expenses.amount),
            ),
          ],
        ),
      ),
    );
  }
}
