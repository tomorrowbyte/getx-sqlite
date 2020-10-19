
class Product{
  int id;
  String productName;
  String productDescription;
  double price;

  Product({this.id, this.productName, this.productDescription,this.price});

  Map<String, dynamic> toMap(){
   var map = Map<String, dynamic>();
   if (id!=null){
     map['id'] = id;
   } 
   map['productName'] = productName;
   map['productDescription'] = productDescription;
   map['price'] = price;
   return map;
  }

  Product.fromMap(Map<String, dynamic> map){
    this.id = map['id'];
    this.productName = map['productName'];
    this.productDescription = map['productDescription'];
    this.price = double.parse(map['price']);

  }
  
}