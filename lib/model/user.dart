import 'package:flutter/material.dart';

class User extends ChangeNotifier{
  final String userId;
  final String email;
  final String userName;
  final String password;

  User({
    this.userId = '',
    this.email = '',
    this.userName = '',
    this.password = '',
  });

  factory User.json(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      userName: json['name'],
      // password: json['password'],
      
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['userName'] = userName;
    //data['password'] = password;
    notifyListeners();
    return data;
  }
}
