import 'package:flutter/material.dart';

class UserViewModel extends ChangeNotifier {
  UserInfo _user;

  UserViewModel(this._user);

  UserInfo get user => this._user;

  set user(UserInfo value) {
    this._user = value;
    notifyListeners();
  }
}
