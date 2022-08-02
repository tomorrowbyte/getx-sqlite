import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_sqflite/models/product.dart';
import 'package:getx_sqflite/utils/database_helper.dart';
import 'package:image_picker/image_picker.dart';

import '../models/product.dart';

class ShoppingController extends GetxController {
  var picker = ImagePicker();
  List<Product> products = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  bool showSearchField = false;

  var imagePath = "";

  void getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath = pickedFile.path;
    }
  }

  @override
  void onInit() {
    products = [];
    fetchProducts();
    super.onInit();
  }

  fetchProducts() async {
    ProductDatabaseHelper.db
        .getProductList()
        .then((productList) => {products = productList});
  }

  void addProduct(Product product) {
    if (product.id != null) {
      print("Inside add product and id is not null ${product.id}");
      ProductDatabaseHelper.db.updateProduct(product).then((value) {
        updateProduct(product);
      });
    } else {
      ProductDatabaseHelper.db
          .insertProduct(product)
          .then((value) => products.add(product));
    }
  }

  void deleteProduct(Product product) {
    ProductDatabaseHelper.db
        .deleteProduct(product.id)
        .then((_) => products.remove(product));
  }

  void updateList(Product product) async {
    var result = await fetchProducts();
    if (result != null) {
      final index = products.indexOf(product);
      print(index);
      products[index] = product;
    }
  }

  void updateProduct(Product product) {
    ProductDatabaseHelper.db
        .updateProduct(product)
        .then((value) => updateList(product));
  }

  void handleAddButton([id]) {
    print(id);
    if (id != null) {
      var product = Product(
        id: id,
        name: nameController.text,
        description: descriptionController.text,
        price: double.parse(priceController.text),
        image: imagePath,
      );
      addProduct(product);
    } else {
      var product = Product(
        name: nameController.text,
        description: descriptionController.text,
        price: double.parse(priceController.text),
        image: imagePath,
      );
      addProduct(product);
    }
    nameController.text = "";
    descriptionController.text = "";
    priceController.text = "";
    imagePath = "";
  }

  void toggleShowSearch() {
    showSearchField = !showSearchField;
  }

  @override
  void onClose() {
    ProductDatabaseHelper.db.close();
    super.onClose();
  }
}
