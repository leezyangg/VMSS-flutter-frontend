import "package:flutter/material.dart";

class OrderList extends StatefulWidget {
  const OrderList({super.key});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to UM - VM2!'),
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
      ),
    );
  }
}
