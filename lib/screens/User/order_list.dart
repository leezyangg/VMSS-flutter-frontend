// ignore_for_file: avoid_print, use_build_context_synchronously

import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import "../../models/product.dart";
import '../../providers/user_state.dart';
import "../../widgets/gradient_button.dart";
import 'package:http/http.dart';
import '../../utils/config.dart';
import 'dart:convert';

class OrderList extends StatefulWidget {
  final String vmID;
  final List<OrderData> selectedOrderData;
  final String vmName;
  const OrderList(
      {Key? key,
      required this.selectedOrderData,
      required this.vmID,
      required this.vmName})
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
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Flexible(
              child: Tooltip(
                message: widget.vmName,
                child: Text(
                  widget.vmName,
                  style: TextStyle(
                    color: Colors.blue[900],
                    fontSize: 20.0,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home_outlined),
            iconSize: 35.0,
            color: Colors.black,
            onPressed: () {
              // Logic here
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).popAndPushNamed('/usermain');
            },
          ),
        ],
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
                        leading: Image.network(
                          orderData.product.photoUrl,
                          width: 90,
                          height: 100,
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
                placeOrder();
              },
            ),
          ),
        ],
      ),
    );
  }

  void placeOrder() async {
    try {
      UserState userState = Provider.of<UserState>(context, listen: false);
      String url =
          '${Config.apiLink}/orders/${widget.vmID}/${userState.userId}';

      var orderDataList = widget.selectedOrderData.map((orderData) {
        return {
          'stockName': orderData.product.name,
          'level': orderData.product.layer,
          'sellPrice': orderData.product.price,
          'orderedQuantity': orderData.quantity,
        };
      }).toList();

      if (orderDataList.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Empty Order'),
              content: const Text('Please select the product before payment'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Show loading indicator
        showDialog(
            context: context,
            builder: (context) {
              return Center(child: CircularProgressIndicator());
            });

        var body = {'items': orderDataList};
        Response response = await post(Uri.parse(url),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(body));
        print(jsonEncode(body));
        Navigator.pop(context);
        if (response.statusCode == 200) {
          print('Order placed successfully!');
          print(response.body);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.popAndPushNamed(context, '/usermain');
          Navigator.pushNamed(context, '/ordersuccess');
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Order Fail'),
                content: Text(
                    'Failed to place order. Error: ${response.statusCode}'),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).popAndPushNamed('/usermain');
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
          print('Failed to place order. Error: ${response.statusCode}');
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
