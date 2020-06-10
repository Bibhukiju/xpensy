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

List<ExModel> expenses = [];
