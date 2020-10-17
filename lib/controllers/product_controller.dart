import 'package:get/get.dart';
import 'package:getx_sqflite/models/product.dart';

class ShoppingController extends GetxController {
  var products = List<Product>().obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    Future.delayed(Duration(seconds: 1));
    var serverResponse = [
      Product(id: 1, productName: "First prod", productDescription: "An amazaing prod", price: 30),
      Product(id: 2, productName: "Second prod", productDescription: "An amazaing product", price: 39.23),
      Product(id: 3, productName: "Third prod", productDescription: "An amazaing prod", price: 99.99),
      Product(id: 4, productName: "Fouth prod", productDescription: "An amazaing prod", price: 1.09),
    ];
    products.value = serverResponse;

  }

}
