class Expenses {
  final int id;
  final String desc;
  final String date;
  final String amount;
  final String photoname;
  Expenses({this.amount, this.date, this.desc, this.id, this.photoname});
  Expenses.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        desc = map["desc"],
        date = map["date"],
        amount = map["amount"],
        photoname = map["photoname"];
  Map<String, dynamic> toJsonMap() => {
        'id': id,
        'desc': desc,
        'date': date,
        'amount': amount,
        'photoname': photoname
      };
}
