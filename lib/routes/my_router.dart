import "package:flutter/material.dart";
import 'package:vemdora_flutter_frontend/screens/Supplier/supplier_main_page.dart';
import 'package:vemdora_flutter_frontend/screens/Supplier/supplier_update_list.dart';
import 'package:vemdora_flutter_frontend/screens/Supplier/update_successful.dart';
import 'package:vemdora_flutter_frontend/screens/User/order_list.dart';
import 'package:vemdora_flutter_frontend/screens/User/order_successful.dart';
import 'package:vemdora_flutter_frontend/screens/User/wallet_page.dart';
import 'package:vemdora_flutter_frontend/screens/login.dart';
import 'package:vemdora_flutter_frontend/screens/qr_code_scanner.dart';
import 'package:vemdora_flutter_frontend/screens/signup.dart';
import 'package:vemdora_flutter_frontend/screens/User/user_main_page.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings setting) {
    // initialization of variables
    const String login = '/';
    const String signup = '/signup';
    const String userMainPage = '/usermain';
    const String supplierMainPage = '/suppliermain';
    const String walletPage = '/wallet';
    const String supplierUpdatePage = '/supplierlist';
    const String qrScannerPage = '/qrcodescanner';
    const String orderList = '/orderlist';
    const String orderSuccess = '/ordersuccess';
    const String updateSuccess = './updatesuccess';

    switch (setting.name) {
      case login:
        return MaterialPageRoute(builder: (context) => const Login());
      case signup:
        return MaterialPageRoute(builder: (context) => const SignUp());
      case userMainPage:
        return MaterialPageRoute(builder: (context) => const UserMainPage());
      case walletPage:
        return MaterialPageRoute(builder: (context) => const WalletPage());
      case supplierUpdatePage:
        return MaterialPageRoute(
            builder: (context) => const SupplierUpdateList());
      case supplierMainPage:
        return MaterialPageRoute(
            builder: (context) => const SupplierMainPage());
      case qrScannerPage:
        return MaterialPageRoute(builder: (context) => const QrCodeScanner());
      case orderList:
        return MaterialPageRoute(builder: (context) => const OrderList());
      case orderSuccess:
        return MaterialPageRoute(
            builder: (context) => const OrderSuccessfulPage());
      case updateSuccess:
        return MaterialPageRoute(
            builder: (context) => const UpdateSuccessfulPage());
    }

    //default case
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Text('no route defined'),
      ),
    );
  }
}
