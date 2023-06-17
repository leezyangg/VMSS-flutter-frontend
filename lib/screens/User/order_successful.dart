import "package:flutter/material.dart";

class OrderSuccessfulPage extends StatelessWidget {
  const OrderSuccessfulPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(188, 219, 255, 1),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Order Success',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 150,
            ),
            Image.asset('assets/images/order_successful.png'),

            const SizedBox(
              height: 30,
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: Text(
                'Your order was successful !',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(
              height: 50,
            ),

            // text
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'You will get your product within few seconds at the Vending Machine.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
