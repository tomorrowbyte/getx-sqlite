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
    if (product.id != null) {
      product.id = null;
    }
    ProductDatabaseHelper.db.insertProduct(product, cart: true).then((id) {
      product.id = id;
      cartItems.add(product);
    });
  }

  void removeFromCart(Product product) {
    if (product.id != null) {
      ProductDatabaseHelper.db
          .deleteProduct(product.id, cart: true)
          .then((value) => {cartItems.remove(product)});
    }
  }

  void resetCart() async {
    cartItems.forEach((product) async {
      print("${product.id} ${product.productName}");
      var result =
          await ProductDatabaseHelper.db.deleteProduct(product.id, cart: true);
      if (result == 1) {
        cartItems.remove(product);
      } else {
        await ProductDatabaseHelper.db.deleteProduct(product.id, cart: true);
      }
    });
    //  cartItems.value = [];
  }
}
