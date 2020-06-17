import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xpensy/Helpers/dbhelper.dart';
import 'package:xpensy/models/expenseModel.dart';
import 'package:xpensy/pages/homescreen.dart';

class Editpage extends StatefulWidget {
  final Expenses expenses;
  Editpage({this.expenses});

  @override
  _EditpageState createState() => _EditpageState();
}

class _EditpageState extends State<Editpage> {
  String _selecteddate;
  TextEditingController amount = TextEditingController();
  TextEditingController smallDesc = TextEditingController();
  Future<File> imageFile;
  File image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text("Edit Expenses"),
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
                GestureDetector(
                  onTap: () async {
                    showDialog(
                        context: context,
                        child: SimpleDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          children: <Widget>[
                            SimpleDialogOption(
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.camera_alt),
                                  Text("Camera"),
                                ],
                              ),
                              onPressed: () async {
                                final pickedImg = await picker.getImage(
                                    source: ImageSource.camera);
                                setState(() {
                                  image = File(pickedImg.path);
                                  Navigator.pop(context);
                                });
                              },
                            ),
                            SimpleDialogOption(
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.image),
                                  Text("Gallery"),
                                ],
                              ),
                              onPressed: () async {
                                final pickedImg = await picker.getImage(
                                    source: ImageSource.gallery);
                                setState(() {
                                  image = File(pickedImg.path);
                                  Navigator.pop(context);
                                });
                              },
                            ),
                          ],
                        ));
                  },
                  child: widget.expenses.photoname != " "
                      ? Container(
                          height: MediaQuery.of(context).size.height / 4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: image != null
                                ? Card(
                                    child: Image.file(image),
                                  )
                                : Card(
                                    elevation: 10,
                                    child: Image.memory(base64Decode(
                                        widget.expenses.photoname))),
                          ),
                        )
                      : Text(""),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      elevation: 10,
                      color: Colors.white,
                      child: TextField(
                        controller: amount,
                        decoration: InputDecoration(
                            hintText: widget.expenses.amount,
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
                      elevation: 10,
                      color: Colors.white,
                      child: TextField(
                        controller: smallDesc,
                        maxLines: 7,
                        decoration: InputDecoration(
                          hintText: widget.expenses.desc,
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
                )
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () async {
            int updateId = await DBHelper.instance.update({
              DBHelper.columnId: widget.expenses.id,
              DBHelper.amount:
                  amount.text == "" ? widget.expenses.amount : amount.text,
              DBHelper.desc:
                  smallDesc.text == "" ? widget.expenses.desc : smallDesc.text,
              DBHelper.cdate:
                  _selecteddate == null ? widget.expenses.date : _selecteddate,
              DBHelper.photoname: image == null
                  ? widget.expenses.photoname
                  : base64Encode(image.readAsBytesSync())
            });
            print(updateId);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => HomeScreen()));
          }),
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
