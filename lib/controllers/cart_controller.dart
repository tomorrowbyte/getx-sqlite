import 'package:get/get.dart';
import 'package:getx_sqflite/models/product.dart';
import 'package:getx_sqflite/utils/database_helper.dart';

class CartController extends GetxController {
  var cartItems = List<Product>().obs;

  @override
  void onInit() {
    ProductDatabaseHelper.db
        .getCartProductList()
        .then((cartList) => {cartItems.value = cartList});
    super.onInit();
  }

  double get totalPrice => cartItems.fold(0, (sum, item) => sum + item.price);
  int get count => cartItems.length;

  void addToCart(Product product) {
    ProductDatabaseHelper.db
        .insertProduct(product, cart: true)
        .then((_) => cartItems.add(product));
  }

  void removeFromCart(Product product) {
    ProductDatabaseHelper.db
        .deleteProduct(product.id, cart: true)
        .then((value) => {cartItems.remove(product)});
  }
}
