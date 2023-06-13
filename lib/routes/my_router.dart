import "package:flutter/material.dart";
import 'package:vemdora_flutter_frontend/screens/Supplier/supplier_main_page.dart';
import 'package:vemdora_flutter_frontend/screens/Supplier/supplier_menu_list.dart';
import 'package:vemdora_flutter_frontend/screens/Supplier/update_list.dart';
import 'package:vemdora_flutter_frontend/screens/Supplier/update_successful.dart';
import 'package:vemdora_flutter_frontend/screens/User/order_list.dart';
import 'package:vemdora_flutter_frontend/screens/User/order_successful.dart';
import 'package:vemdora_flutter_frontend/screens/User/wallet_page.dart';
import 'package:vemdora_flutter_frontend/screens/User/wallet_top_up_page.dart';
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
    const String walletTopUpPage = '/wallettopup';

    switch (setting.name) {
      case login:
        return MaterialPageRoute(builder: (context) => const Login());
      case signup:
        return MaterialPageRoute(builder: (context) => const SignUp());
      case qrScannerPage:
        return MaterialPageRoute(builder: (context) => const QRScanner());

      // User Pages
      case userMainPage:
        return MaterialPageRoute(builder: (context) => const UserMainPage());
      case walletPage:
        return MaterialPageRoute(builder: (context) => const WalletPage());
      case walletTopUpPage:
        return MaterialPageRoute(builder: (context) => const WalletTopUpPage());
      case usermenulist:
        final String barcode = setting.arguments as String;
        return MaterialPageRoute(
            builder: (context) => UserMenuList(code: barcode));
      // builder: (context) => const UserMenuList());
      case orderList:
        final Map<String, dynamic> arguments =
            setting.arguments as Map<String, dynamic>;
        final List<OrderData> selectedOrderData =
            arguments['selectedOrderData'] as List<OrderData>;
        final String barcode = arguments['barcode'] as String;
        return MaterialPageRoute(
          builder: (context) =>
              OrderList(selectedOrderData: selectedOrderData, vmID: barcode),
        );
      case orderSuccessPage:
        return MaterialPageRoute(
            builder: (context) => const OrderSuccessfulPage());

      // Supplier Pages
      case supplierMainPage:
        return MaterialPageRoute(
            builder: (context) => const SupplierMainPage());
      case suppliermenulist:
        final String barcode = setting.arguments as String;
        return MaterialPageRoute(
            builder: (context) => SupplierMenuList(code: barcode));
      case updateList:
        final Map<String, dynamic> arguments =
            setting.arguments as Map<String, dynamic>;
        final List<UpdateData> selectedUpdateData =
            arguments['selectedUpdateData'] as List<UpdateData>;
        final String barcode = arguments['barcode'] as String;
        return MaterialPageRoute(
            builder: (context) => UpdateList(
                selectedUpdateData: selectedUpdateData, vmID: barcode));
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
