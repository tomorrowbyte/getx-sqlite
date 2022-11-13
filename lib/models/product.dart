class Product {
  final int? id;
  final String name;
  final String description;
  final double price;
  final String image;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image': image,
    };
  }

  Product.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        description = map['description'],
        image = map['image'],
        price = double.parse(map['price']);

  Product copyWith({
    int? id,
    String? name,
    String? description,
    double? price,
    String? image,
  }) =>
      Product(
          id: id,
          name: name ?? this.name,
          description: description ?? this.description,
          price: price ?? this.price,
          image: image ?? this.image);
}
