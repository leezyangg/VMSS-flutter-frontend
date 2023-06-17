// ignore_for_file: use_key_in_widget_constructors, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vemdora_flutter_frontend/screens/login.dart';
import 'package:vemdora_flutter_frontend/widgets/gradient_button.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart';
import '../../utils/config.dart';
import '../../providers/user_state.dart';

class UserMainPage extends StatelessWidget {
  const UserMainPage({Key? key});

  // Fetch wallet amount
  Future<void> fetchWalletData(BuildContext context) async {
    UserState userState = Provider.of<UserState>(context, listen: false);
    String userID = userState.userId;
    String myConfig = Config.apiLink;

    try {
      Response response = await get(Uri.parse('$myConfig/ewallets/$userID'));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        double walletValue = data['walletValue'].toDouble();
        userState.setWalletValue(walletValue);
      } else {
        print('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchWalletData(context);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(188, 219, 255, 1),
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 70,
              ),
              Image.asset('assets/images/vemdora_icon.png'),
              PurpleGradientButton(
                buttonText: 'Scan QR Code',
                onPress: () {
                  Navigator.of(context).pushNamed('/qrcodescanner');
                },
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'To view product lists of vending machine...',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    UserState userState = Provider.of<UserState>(context);
    String value = 'RM ${userState.getWalletValue().toStringAsFixed(2)}';

    return AppBar(
      title: Text(
        value,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      actions: <Widget>[
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Sign Out'),
                  content: Text('Are you sure You want to Sign Out?'),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => (const Login())),
                          (route) => false,
                        );
                      },
                      child: const Text('Yes'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('No'),
                    ),
                  ],
                );
              },
            );
          },
          icon: Icon(
            Icons.home_outlined,
            color: Colors.grey[800],
            size: 33,
          ),
        ),
      ],
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/wallet');
        },
        icon: Icon(
          Icons.account_balance_wallet_outlined,
          color: Colors.grey[700],
          size: 33,
        ),
      ),
    );
  }
}
