import "package:flutter/material.dart";
import 'package:vemdora_flutter_frontend/screens/Supplier/supplier_main_page.dart';
import 'package:vemdora_flutter_frontend/screens/Supplier/supplier_menu_list.dart';
import 'package:vemdora_flutter_frontend/screens/Supplier/update_list.dart';
import 'package:vemdora_flutter_frontend/screens/Supplier/update_successful.dart';
import 'package:vemdora_flutter_frontend/screens/User/order_list.dart';
import 'package:vemdora_flutter_frontend/screens/User/order_successful.dart';
import 'package:vemdora_flutter_frontend/screens/User/wallet_page.dart';
import 'package:vemdora_flutter_frontend/screens/login.dart';
import 'package:vemdora_flutter_frontend/screens/User/user_menu_list.dart';
import 'package:vemdora_flutter_frontend/screens/qr_code_scanner.dart';
import 'package:vemdora_flutter_frontend/screens/signup.dart';
import 'package:vemdora_flutter_frontend/screens/User/user_main_page.dart';

import '../models/product.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings setting) {
    // initialization of variables
    const String login = '/';
    const String signup = '/signup';
    const String userMainPage = '/usermain';
    const String supplierMainPage = '/suppliermain';
    const String walletPage = '/wallet';
    const String suppliermenulist = '/suppliermenulist';
    const String updateList = '/updatelist';
    const String qrScannerPage = '/qrcodescanner';
    const String usermenulist = '/usermenulist';
    const String orderList = '/orderlist';
    const String orderSuccessPage = '/ordersuccess';
    const String updateSuccess = '/updatesuccess';

    switch (setting.name) {
      case login:
        return MaterialPageRoute(builder: (context) => const Login());
      case signup:
        return MaterialPageRoute(builder: (context) => const SignUp());
      case qrScannerPage:
        return MaterialPageRoute(builder: (context) => const QrCodeScanner());

      // User Pages
      case userMainPage:
        return MaterialPageRoute(builder: (context) => const UserMainPage());
      case walletPage:
        return MaterialPageRoute(builder: (context) => const WalletPage());
      case usermenulist:
        return MaterialPageRoute(builder: (context) => const UserMenuList());
      case orderList:
        final List<OrderData> selectedOrderData =
            setting.arguments as List<OrderData>;
        return MaterialPageRoute(
          builder: (context) => OrderList(selectedOrderData: selectedOrderData),
        );
      case orderSuccessPage:
        return MaterialPageRoute(
            builder: (context) => const OrderSuccessfulPage());

      // Supplier Pages
      case supplierMainPage:
        return MaterialPageRoute(
            builder: (context) => const SupplierMainPage());
      case suppliermenulist:
        return MaterialPageRoute(
            builder: (context) => const SupplierMenuList());
      case updateList:
        final List<UpdateData> selectedUpdateData =
            setting.arguments as List<UpdateData>;
        return MaterialPageRoute(
            builder: (context) =>
                UpdateList(selectedUpdateData: selectedUpdateData));
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
