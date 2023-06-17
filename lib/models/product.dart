class Product {
  final int id;
  final String name;
  final String photoUrl;
  final double price;
  final int layer;

  Product({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.price,
    required this.layer,
  });
}

List<Product> products = [];

class OrderData {
  final Product product;
  final int quantity;

  OrderData(this.product, this.quantity);
}

class UpdateData {
  final Product product;
  final int quantity;

  UpdateData(this.product, this.quantity);
}
