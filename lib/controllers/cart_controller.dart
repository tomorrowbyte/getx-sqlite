import 'package:get/get.dart';
import 'package:getx_sqflite/models/product.dart';

class CartController extends GetxController {
  var cartItems = List<Product>().obs;

  double get totalPrice => cartItems.fold(0, (sum, item) => sum + item.price);
  int get count => cartItems.length;

  void addToCart(Product product) {
    cartItems.add(product);
  }
}
