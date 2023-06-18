import "package:flutter/material.dart";
import 'package:vemdora_flutter_frontend/screens/login.dart';
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
              Icons.logout,
              color: Colors.grey[800],
              size: 26,
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
              Hero(
                tag: 'vemdora icon',
                child: Image.asset('assets/images/vemdora_icon.png'),
              ),
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
