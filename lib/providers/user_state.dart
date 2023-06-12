import 'package:flutter/material.dart';

enum UserType { supplier, publicUser }

class UserState extends ChangeNotifier {
  UserType _userType = UserType.publicUser;
  double _walletValue = 0.0;
  String _userId = '';
  String _userName = '';
  int _vmID = 0;

  UserType get userType => _userType;
  String get userId => _userId;
  double get walletValue => _walletValue;
  String get userName => _userName;
  int get vmID => _vmID;

  void setUserType(UserType type) {
    _userType = type;
    notifyListeners();
  }

  void setUserId(String id) {
    _userId = id;
    notifyListeners();
  }

  void setWalletValue(double walletValue) {
    _walletValue = walletValue;
    notifyListeners();
  }

  void setUserName(String userName) {
    _userName = userName;
    notifyListeners();
  }

  void setVMID(int vmID) {
    _vmID = vmID;
    notifyListeners();
  }

  // Getter method for wallet value
  double getWalletValue() {
    return walletValue;
  }
}
