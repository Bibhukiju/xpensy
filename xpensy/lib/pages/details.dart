import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:xpensy/Helpers/dbhelper.dart';
import 'package:xpensy/models/expenseModel.dart';
import 'package:xpensy/pages/editpage.dart';
import 'package:xpensy/pages/homescreen.dart';

class Details extends StatefulWidget {
  final Expenses expenses;
  Details({this.expenses});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    delete() {
      showDialog(
          context: context,
          child: SimpleDialog(
            title: Text("Do you want to delete"),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            children: <Widget>[
              SimpleDialogOption(
                child: Text(
                  "Delete",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () async {
                  await DBHelper.instance.delete(widget.expenses.id);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => HomeScreen()));
                },
              ),
              SimpleDialogOption(
                child: Text("cancel"),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          ));
    }

    navigate() {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => Editpage(
                expenses: widget.expenses,
              )));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.expenses.desc),
          centerTitle: true,
          elevation: 0,
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Hero(
                tag: widget.expenses.id,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all()),
                  height: MediaQuery.of(context).size.height / 2,
                  child: widget.expenses.photoname == " "
                      ? Icon(
                          Icons.broken_image,
                          color: Theme.of(context).primaryColor,
                          size: MediaQuery.of(context).size.height / 4,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.memory(
                            base64Decode(widget.expenses.photoname),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  height: MediaQuery.of(context).size.height / 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      detailsRow(data: widget.expenses.amount, title: "Amount"),
                      detailsRow(
                          title: "Category", data: widget.expenses.catergory),
                      detailsRow(
                          title: "Date of expenses",
                          data: widget.expenses.date),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          createButton(context, delete,
                              col: Colors.red, ico: Icons.delete_outline),
                          createButton(context, navigate,
                              ico: Icons.mode_edit, col: Colors.green)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  OutlineButton createButton(BuildContext context, Function fun,
      {IconData ico, Color col}) {
    return OutlineButton(
      borderSide: BorderSide(
        color: Colors.teal,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: fun,
      child: Icon(
        ico,
        color: col,
      ),
    );
  }

  Row detailsRow({@required String title, @required String data}) {
    return Row(
      children: <Widget>[
        Text(
          title + ":  ",
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
        Text(data),
      ],
    );
  }
}
