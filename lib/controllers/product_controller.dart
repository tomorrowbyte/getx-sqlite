import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_sqflite/models/product.dart';
import 'package:getx_sqflite/utils/database_helper.dart';

class ShoppingController extends GetxController {
  var products = List<Product>().obs;
  var nameController = TextEditingController().obs;
  var descriptionController = TextEditingController().obs;
  var priceController = TextEditingController().obs;

  @override
  void onInit() {
    products.value = [];
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    ProductDatabaseHelper.db
        .getProductList()
        .then((productList) => {products.value = productList});
  }

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

  void updateList(Product product) {
    final index = products.indexOf(product);
    products[index] = product;
  }

  void updateProduct(Product product) {
    ProductDatabaseHelper.db
        .updateProduct(product)
        .then((value) => updateList(product));
  }

  void handleAddButton() {
    var product = Product(
      productName: nameController.value.text,
      productDescription: descriptionController.value.text,
      price: double.parse(priceController.value.text),
    );
    nameController.value.text = "";
    descriptionController.value.text = "";
    priceController.value.text = "";
    addProduct(product);
  }
}
