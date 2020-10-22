class Product {
  int id;
  String name;
  String description;
  double price;
  String image;

  Product({this.id, this.name, this.description, this.price, this.image});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['name'] = name;
    map['description'] = description;
    map['price'] = price;
    map['image'] = image;
    return map;
  }

  Product.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.description = map['description'];
    this.image = map['image'];
    this.price = double.parse(map['price']);
  }
}
