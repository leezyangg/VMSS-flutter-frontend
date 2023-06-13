import "package:flutter/material.dart";
import 'package:vemdora_flutter_frontend/widgets/gradient_button.dart';

class SupplierMainPage extends StatelessWidget {
  const SupplierMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(188, 219, 255, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: <Widget>[
          // logout button
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/');
            },
            icon: const Icon(
              Icons.logout_rounded,
              color: Colors.black,
            ),
          )
        ],

        // wallet button
      ),
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

              // text
              const Text(
                'To view catalog of vending machine...',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
