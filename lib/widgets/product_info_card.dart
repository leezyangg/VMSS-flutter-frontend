import "package:flutter/material.dart";

class ProductInfo extends StatelessWidget {
  final String image;
  final double cost;
  final String name;
  const ProductInfo(
      {super.key, required this.image, required this.cost, required this.name});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(50),
        padding: const EdgeInsets.symmetric(vertical: 100),
        color: Colors.white,
        child: Column(
          children: [
            const Icon(
              Icons.favorite_outline,
              color: Colors.white,
            ),
            Image.asset(
              image,
              height: 100,
            ),
            Text('RM ${cost.toStringAsFixed(2)}'),
            Text(name),
          ],
        ),
      ),
    );
  }
}
