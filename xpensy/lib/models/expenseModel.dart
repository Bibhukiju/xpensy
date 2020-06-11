class Expenses {
  final int id;
  final String desc;
  final String date;
  final String amount;
  Expenses({this.amount, this.date, this.desc, this.id});
  Expenses.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        desc = map["desc"],
        date = map["date"],
        amount = map["amount"];
  Map<String, dynamic> toJsonMap() =>
      {'id': id, 'desc': desc, 'date': date, 'amount': amount};
}
