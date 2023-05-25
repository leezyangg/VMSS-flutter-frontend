import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vmss/model/product.dart';

class menuList extends StatefulWidget {
  const menuList({super.key});

  @override
  State<menuList> createState() => _menuListState();
}

class _menuListState extends State<menuList> {
  int selectedLayer = 1;
  Map<int, int> quantityMap = {}; //maintain the product quantity value
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

  //change the menu based on layer choose
  void _onLayerChanged(int layer) {
    setState(() {
      selectedLayer = layer;
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
          Image.asset(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(126, 179, 222, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                // Handle home icon pressed
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
          buildButton("Place Order"),
        ],
      ),
    );
  }

  Widget buildButton(String buttonText) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 161, 97, 220),
            Colors.purple
          ], // Customize the gradient colors
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ElevatedButton(
        onPressed: () {
          // Handle the "Place Order" button press
          // Add your desired logic here
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
