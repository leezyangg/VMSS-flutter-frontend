// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:vemdora_flutter_frontend/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../utils/config.dart';

class UserMenuList extends StatefulWidget {
  final String code;

  const UserMenuList({Key? key, required this.code})
      : super(key: key); // real path
  // const UserMenuList({super.key});
  @override
  State<UserMenuList> createState() => _UserMenuListState();
}

class _UserMenuListState extends State<UserMenuList> {
  int selectedLayer = 1;
  Map<int, int> quantityMap = {};
  List<OrderData> selectedOrders = [];
  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    String myConfig = Config.apiLink;
    final response = await http
        .get(Uri.parse('$myConfig/vendingMachines/${widget.code}/items'));
    // .get(Uri.parse('$myConfig/vendingMachines/1/items')); // Test for vm1
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Product> fetchedProducts = [];

      for (var item in data['items']) {
        String imagePreLink = Config.imagePreLink;
        final product = Product(
          id: item['stockID'],
          name: item['stockName'],
          photoUrl: "$imagePreLink${item['imageURL']}",
          price: double.parse(item['sellPrice'].toString()),
          layer: item['level'],
        );

        fetchedProducts.add(product);
      }

      setState(() {
        products = fetchedProducts;
      });
    } else {
      print('Failed to fetch products. Error: ${response.statusCode}');
    }
  }
  //maintain the product quantity value
  //show the dropdown list to choose the layer

  void showLayerDropdownMenu(BuildContext context) {
    showMenu<int>(
      context: context,
      position: const RelativeRect.fromLTRB(0.0, kToolbarHeight, 0.0, 0.0),
      items: <PopupMenuEntry<int>>[
        const PopupMenuItem<int>(
          value: 1,
          child: Text('Layer 1'),
        ),
        const PopupMenuItem<int>(
          value: 2,
          child: Text('Layer 2'),
        ),
        const PopupMenuItem<int>(
          value: 3,
          child: Text('Layer 3'),
        ),
        const PopupMenuItem<int>(
          value: 4,
          child: Text('Layer 4'),
        ),
        const PopupMenuItem<int>(
          value: 5,
          child: Text('Layer 5'),
        ),
      ],
    ).then((layer) {
      if (layer != null) {
        setState(() {
          selectedLayer = layer;
        });
      }
    });
  }

  List<Product> getProductsByLayer(int layer) {
    return products.where((product) => product.layer == layer).toList();
  }

  Widget buildProductList(List<Product> products) {
    return ListView.builder(
      itemCount: (products.length / 2).ceil(),
      itemBuilder: (context, index) {
        int startIndex = index * 2;
        int endIndex = (startIndex + 2).clamp(0, products.length);

        List<Product> sublist = products.sublist(startIndex, endIndex);

        if (sublist.length == 1) {
          // If there is only one item in the sublist
          // Align it to the left
          Product product = sublist[0];
          int quantity = quantityMap[product.id] ??
              0; // Retrieve the quantity from the map
          return Row(
            children: [
              Expanded(
                child: buildItemContainer(product, quantity),
              ),
              Expanded(
                  child:
                      Container()), // Empty container to take the remaining space
            ],
          );
        } else {
          // If there are two items in the sublist
          // Display them normally
          return Row(
            children: sublist.map((product) {
              int quantity = quantityMap[product.id] ??
                  0; // Retrieve the quantity from the map

              return Expanded(
                child: buildItemContainer(product, quantity),
              );
            }).toList(),
          );
        }
      },
    );
  }

  Widget buildItemContainer(Product product, int quantity) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: [
          Image.network(
            product.photoUrl,
            width: 150,
            height: 150,
            fit: BoxFit.contain,
          ),
          Text(
            product.name,
            style: const TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'RM ${product.price.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 15.0),
          ),
          buildQuantityRow(product, quantity),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(188, 219, 255, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.format_list_bulleted_sharp,
                  color: Colors.black),
              onPressed: () {
                showLayerDropdownMenu(context);
              },
            ),
            const SizedBox(
              width: 15.0,
            ),
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
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 15.0,
          ),
          const Text(
            'Please select your item',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: buildProductList(getProductsByLayer(selectedLayer)),
          ),
          buildButton('Place Order')
        ],
      ),
    );
  }

  // quantity selected
  Widget buildQuantityRow(Product product, int quantity) {
    void incrementQuantity() {
      setState(() {
        quantityMap[product.id] = (quantityMap[product.id] ?? 0) + 1;
      });
    }

    void decrementQuantity() {
      setState(() {
        if (quantity > 0) {
          quantityMap[product.id] = (quantityMap[product.id] ?? 0) - 1;
        }
      });
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: decrementQuantity,
        ),
        Text(quantity.toString()),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: incrementQuantity,
        ),
      ],
    );
  }

  void navigateToConfirmationPage() {
    List<OrderData> selectedOrderData = [];

    // Create OrderData objects from selected products and quantities
    for (Product product in products) {
      int quantity = quantityMap[product.id] ?? 0;
      if (quantity > 0) {
        selectedOrderData.add(OrderData(product, quantity));
      }
    }

    // Navigate to the confirmation page and pass the selected order data
    Navigator.pushNamed(
      context,
      '/orderlist',
      arguments: {
        'selectedOrderData': selectedOrderData,
        'barcode': widget.code,
      },
    );
  }

  Widget buildButton(String buttonText) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(152, 129, 220, 1),
            Color.fromRGBO(197, 29, 150, 1),
          ], // Customize the gradient colors
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ElevatedButton(
        onPressed: () {
          // Logic here
          navigateToConfirmationPage();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          elevation: MaterialStateProperty.all(0),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
