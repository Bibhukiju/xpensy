import 'package:flutter/cupertino.dart';

class ExModel {
  DateTime dateTime;
  String title;
  String amount;
  String smalldesc;
  String imgUrl;
  ExModel(
      {@required this.amount,
      @required this.dateTime,
      this.smalldesc,
      this.imgUrl,
      @required this.title});
}

List<ExModel> expenses = [
  ExModel(
      amount: "100",
      dateTime: DateTime.now(),
      title: "Mo:Mo",
      imgUrl: "https://i.ytimg.com/vi/7tdUCk9pLPw/maxresdefault.jpg"),
  ExModel(
      amount: "200",
      dateTime: DateTime.now(),
      title: "Chowmein",
      imgUrl: "https://c.ndtvimg.com/mnng9ei8_chowmein_640x480_25_July_18.jpg")
];
