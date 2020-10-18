import 'package:get/get.dart';
import 'package:getx_sqflite/models/product.dart';
import 'package:getx_sqflite/utils/database_helper.dart';

class ShoppingController extends GetxController {
  var products = List<Product>().obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    ProductDatabaseHelper.db.getProductList().then((productList) => {
      products.value = productList
    });

  }

}
