import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:vemdora_flutter_frontend/widgets/gradient_button.dart';
import '../../providers/user_state.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    UserState userState = Provider.of<UserState>(context);
    String value = 'RM ${userState.getWalletValue().toStringAsFixed(2)}';
    return Scaffold(
      backgroundColor: const Color.fromRGBO(188, 219, 255, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
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
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Hero(
                tag: 'wallet icon',
                child: Image.asset('assets/images/wallet.png'),
              ),
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
              Text(
                value,
                style: const TextStyle(
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
                  Navigator.of(context).pushNamed('/wallettopup');
                  // Navigator.popAndPushNamed(context, '/wallettopup');
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
      ),
    );
  }
}
