// ignore_for_file: avoid_print

import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:http/http.dart';
import '../../utils/config.dart';
import '../../providers/user_state.dart';
import 'package:vemdora_flutter_frontend/widgets/gradient_button.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({Key? key}) : super(key: key);

  Future<void> fetchWalletData(BuildContext context) async {
    UserState userState = Provider.of<UserState>(context, listen: false);
    String userID = userState.userId;
    String myConfig = Config.apiLink;

    try {
      Response response = await get(Uri.parse('$myConfig/ewallets/$userID'));
      if (response.statusCode == 200) {
        // Process the response data here
      } else {
        print('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchWalletData(context); // Call the fetchWalletData method

    return Scaffold(
      backgroundColor: const Color.fromRGBO(188, 219, 255, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/usermain');
          },
          icon: Icon(
            Icons.home_outlined,
            color: Colors.grey[800],
            size: 33,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Image.asset('assets/images/wallet.png'),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Wallet Balance:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'RM 50.00',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            PurpleGradientButton(
              buttonText: 'Top Up',
              onPress: () {
                // Top Up logic Be placed here
              },
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Top Up can only be done using TnG',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}
