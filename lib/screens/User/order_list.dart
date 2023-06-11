import "package:flutter/material.dart";
import "../../models/product.dart";
import "../../widgets/gradient_button.dart";

class OrderList extends StatefulWidget {
  final List<OrderData> selectedOrderData;
  const OrderList({Key? key, required this.selectedOrderData})
      : super(key: key);

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    double totalCost = 0;

    for (var orderData in widget.selectedOrderData) {
      totalCost += orderData.product.price * orderData.quantity;
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(188, 219, 255, 1),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, // Set the desired color for the leading icon
        ),
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text(
              "Welcome to UM - VM2!",
              style: TextStyle(
                color: Colors.blue[900],
                fontSize: 20.0,
              ),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.home_outlined),
              iconSize: 35.0,
              color: Colors.black,
              onPressed: () {
                // Logic here
                Navigator.of(context).pushNamed('/usermain');
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Order List',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.selectedOrderData.length,
              itemBuilder: (context, index) {
                OrderData orderData = widget.selectedOrderData[index];
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 4),
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Image.asset(
                          orderData.product.photoUrl,
                          width: 90, // Adjust the width for a larger image
                          height: 100, // Adjust the height for a larger image
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'RM${orderData.product.price.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Colors.green),
                                ),
                                Text(
                                  orderData.product.name,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '${orderData.quantity}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            child: Text(
              'Total Cost: RM${totalCost.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: PurpleGradientButton(
              buttonText: 'Pay with VemWallet',
              onPress: () {
                // Logic Here
                Navigator.of(context).pushNamed('/ordersuccess');
              },
            ),
          ),
        ],
      ),
    );
  }
}
