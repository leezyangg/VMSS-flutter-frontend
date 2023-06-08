import 'package:flutter/material.dart';

enum UserType { supplier, publicUser }

class UserState extends ChangeNotifier {
  UserType _userType = UserType.publicUser;
  String _userId = '';

  UserType get userType => _userType;
  String get userId => _userId;

  void setUserType(UserType type) {
    _userType = type;
    notifyListeners();
  }

  void setUserId(String id) {
    _userId = id;
    notifyListeners();
  }
}
