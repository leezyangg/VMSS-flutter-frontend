import "package:flutter/material.dart";
import 'package:vemdora_flutter_frontend/widgets/gradient_button.dart';

class UserMainPage extends StatelessWidget {
  const UserMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(188, 219, 255, 1),
      appBar: AppBar(
        title: const Text(
          'RM 50',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: <Widget>[
          // logout button
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/');
            },
            icon: const Icon(
              Icons.home_outlined,
              color: Colors.black,
            ),
          )
        ],

        // wallet button
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/wallet');
          },
          icon: const Icon(
            Icons.account_balance_wallet_outlined,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
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

            // text
            const Text(
              'To view product lists of vending machine...',
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
