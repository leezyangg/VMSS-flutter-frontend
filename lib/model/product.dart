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

List<Product> products = [
  Product(
    id: 1,
    name: 'Dutch Lady',
    photoUrl: 'assets/milk.jpg',
    price: 2.50,
    layer: 1,
  ),
  Product(
    id: 2,
    name: '100 Plus',
    photoUrl: 'assets/100plus.jpg',
    price: 2.80,
    layer: 1,
  ),
  Product(
    id: 3,
    name: 'Milo Tin',
    photoUrl: 'assets/milo.jpg',
    price: 3.50,
    layer: 1,
  ),
  Product(
    id: 4,
    name: 'Marker Pen',
    photoUrl: 'assets/Marker.jpg',
    price: 3.80,
    layer: 2,
  ),
  Product(
    id: 5,
    name: 'Highlight Pen',
    photoUrl: 'assets/stab.jpg',
    price: 4.0,
    layer: 2,
  ),
  Product(
    id: 6,
    name: 'Correction Tape',
    photoUrl: 'assets/correctionTape.jpg',
    price: 4.50,
    layer: 2,
  ),
  // Add more products as needed
];
