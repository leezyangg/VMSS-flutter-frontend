import "package:flutter/material.dart";
import 'package:vemdora_flutter_frontend/screens/login.dart';
import 'package:vemdora_flutter_frontend/screens/signup.dart';
import 'package:vemdora_flutter_frontend/widgets/product_info_card.dart';
//import 'package:vemdora_flutter_frontend/screens/qr_code_scanner.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings setting) {
    // initialization of variables
    const String login = '/';
    const String signup = '/signup';
    // const String scanQr = '/scanqr';
    const String productInfo = '/productinfo';

    switch (setting.name) {
      case login:
        return MaterialPageRoute(builder: (context) => const Login());
      case signup:
        return MaterialPageRoute(builder: (context) => const SignUp());
      // case scanQr:
      //   return MaterialPageRoute(
      //       builder: (context) => const MobileScannerPage());
      case productInfo:
        return MaterialPageRoute(
            builder: (context) => const ProductInfo(
                  image: 'assets/images/milo.jpeg',
                  cost: 3.00,
                  name: 'milo',
                ));
      default:
    }

    //default case
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Text('no route defined'),
      ),
    );
  }
}
