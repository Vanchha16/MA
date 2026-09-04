class Product {
  int id;
  String name;
  String subtitle;
  String image;
  String? description;
  double price;

  Product({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.image,
    required this.price,
    required this.description,
  });
}
