// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';

import "package:flutter/material.dart";
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:vemdora_flutter_frontend/utils/config.dart';
import 'package:vemdora_flutter_frontend/widgets/gradient_button.dart';
import '../../providers/user_state.dart';

class WalletTopUpPage extends StatelessWidget {
  const WalletTopUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController topUpController = TextEditingController();
    UserState userState = Provider.of<UserState>(context);
    String userID = userState.userId;
    String value = 'RM ${userState.getWalletValue().toStringAsFixed(2)}';
    return Scaffold(
      backgroundColor: const Color.fromRGBO(188, 219, 255, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.grey[800],
            size: 33,
            weight: 0.00005,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/images/vemdora_icon.png'),
              const Text(
                'Wallet Balance:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: TextField(
                  controller: topUpController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    prefixIcon: Icon(
                      Icons.attach_money_sharp,
                      color: Colors.grey,
                    ),
                    hintText: 'Enter value here',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              PurpleGradientButton(
                buttonText: 'Top Up',
                onPress: () {
                  int intValue = int.tryParse(topUpController.text) ?? 0;
                  topUp(intValue, userID, context);
                },
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Please enter your top up value',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void topUp(int value, String userID, BuildContext context) async {
    try {
      String url = '${Config.apiLink}/ewallets/$userID';
      var body = {"topUpAmount": value};
      Response response = await post(Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        print('Top Up successfully!');
        print(response.body);
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed('/usermain');
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Top Up Failed'),
              content:
                  const Text('Please Enter the correct Value want to top up'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
