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
//   List<ExModel> expenses = [
//     ExModel(amount: "200", dateTime: DateTime.now(), title: "Test")
//   ];
//   Map<String, dynamic> toMap() {
//     var map = <String, dynamic>{
//       'dateTime': dateTime,
//       'title': title,
//       'amount': amount,
//       'smalldesc': smalldesc,
//       'imgUrl': imgUrl
//     };
//     return map;
//   }

//   ExModel.fromMap(Map<String, dynamic> map) {
//     dateTime = map['dateTime'];
//     title = map['title'];
//     amount = map['amount'];
//     smalldesc = map['smalldesc'];
//     imgUrl = map['imgUrl'];
//   }
// }
}