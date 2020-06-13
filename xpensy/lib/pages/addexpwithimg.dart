import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xpensy/Helpers/dbhelper.dart';
import 'package:xpensy/pages/homescreen.dart';

class AddExpwithImg extends StatefulWidget {
  @override
  _AddExpwithImgState createState() => _AddExpwithImgState();
}

class _AddExpwithImgState extends State<AddExpwithImg> {
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
        title: Text("Add Expenses"),
        centerTitle: true,
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
                    final pickedImg =
                        await picker.getImage(source: ImageSource.gallery);
                    setState(() {
                      image = File(pickedImg.path);
                    });
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height / 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: image != null
                          ? Card(
                              child: Image.file(image),
                            )
                          : Card(
                              elevation: 10,
                              child: Icon(
                                Icons.add_a_photo,
                                color: Theme.of(context).primaryColor,
                                size: MediaQuery.of(context).size.height / 10,
                              )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      elevation: 10,
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
                      elevation: 10,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(2),
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
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
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
                                        width:
                                            MediaQuery.of(context).size.width /
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
        onPressed: () {
          DBHelper.instance.insert({
            DBHelper.desc: smallDesc.text,
            DBHelper.cdate: DateTime.now().toString().split(" ")[0],
            DBHelper.amount: amount.text,
            DBHelper.photoname: base64Encode(image.readAsBytesSync())
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