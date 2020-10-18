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
    ProductDatabaseHelper.db
        .getProductList()
        .then((productList) => {products.value = productList});

    void addProduct(Product product) {
      ProductDatabaseHelper.db
          .insertProduct(product)
          .then((value) => products.add(product));
    }

    void deleteProduct(Product product) {
      ProductDatabaseHelper.db
          .deleteProduct(product.id)
          .then((_) => products.remove(product));
    }

    void update(Product product) {
      final index = products.indexOf(product);
      products[index] = product;
    }

    void updateProduct(Product product) {
      ProductDatabaseHelper.db
          .updateProduct(product)
          .then((value) => update(product));
    }
  }
}
