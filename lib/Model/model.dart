import 'dart:convert';

class User {
  User({
    required this.fname,
    required this.lname,
    required this.email,
    required this.password,
    required this.phone,
    required this.transactions,
    required this.requests,
    this.accountNo,
    this.balance,
    this.cards,
  });
  String fname;
  String lname;
  String email;
  String password;
  String phone;
  late List<Transaction> transactions;
  late List<Request> requests;
  late dynamic accountNo;
  late dynamic balance;
  late dynamic cards;

  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(
      fname: jsonData['fname'],
      lname: jsonData['lname'],
      email: jsonData['email'],
      password: jsonData['password'],
      phone: jsonData['phone'],
      transactions: List<Transaction>.from(
          jsonData["transactions"].map((x) => Transaction.fromJson(x))),
      requests: List<Request>.from(
          jsonData["requests"].map((x) => Request.fromJson(x))),
      accountNo: jsonData['accountNo'],
      balance: jsonData['balance'],
      cards: jsonData['cards'],
    );
  }
  static Map<String, dynamic> toMap(User user) => {
        'fname': user.fname,
        'lname': user.lname,
        'email': user.email,
        'password': user.password,
        'phone': user.phone,
        'transactions':
            List<dynamic>.from(user.transactions.map((x) => x.toJson())),
        'accountNo': user.accountNo,
        'balance': user.balance,
        'cards': user.cards,
        'requests':
            List<dynamic>.from(user.requests.map((x) => x.toJson())),
      };
  static String encode(List<User> users) => json.encode(
        users.map<Map<String, dynamic>>((user) => User.toMap(user)).toList(),
      );
  static List<User> decode(String users) =>
      (json.decode(users) as List<dynamic>)
          .map<User>((item) => User.fromJson(item))
          .toList();
}

class Transaction {
  Transaction({
    this.type,
    this.receiver,
    this.sender,
    this.amount,
    this.date,
  });

  late dynamic type;
  late dynamic receiver;
  late dynamic sender;
  late dynamic amount;
  late dynamic date;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        type: json["type"],
        receiver: json["receiver"],
        sender: json["sender"],
        amount: json["amount"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "receiver": receiver,
        "sender": sender,
        "amount": amount,
        "date": date,
      };
}

class Request {
  Request({
    this.type,
    this.receiver,
    this.sender,
    this.amount,
    this.date,
  });

  late dynamic type;
  late dynamic receiver;
  late dynamic sender;
  late dynamic amount;
  late dynamic date;

  factory Request.fromJson(Map<String, dynamic> json) => Request(
        type: json["type"],
        receiver: json["receiver"],
        sender: json["sender"],
        amount: json["amount"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "receiver": receiver,
        "sender": sender,
        "amount": amount,
        "date": date,
      };
}
