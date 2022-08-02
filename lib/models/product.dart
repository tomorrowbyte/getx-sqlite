class Product {
  int id;
  String name;
  String description;
  double price;
  String image;

  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.image,
  });

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['price'] = price;
    map['image'] = image;
    return map;
  }

  Product.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        description = map['description'],
        image = map['image'],
        price = double.parse(map['price']);
}
