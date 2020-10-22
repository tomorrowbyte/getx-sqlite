import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_sqflite/models/product.dart';
import 'package:getx_sqflite/utils/database_helper.dart';
import 'package:image_picker/image_picker.dart';

class ShoppingController extends GetxController {
  var picker = ImagePicker().obs;
  var products = List<Product>().obs;
  var nameController = TextEditingController().obs;
  var descriptionController = TextEditingController().obs;
  var priceController = TextEditingController().obs;
  var imagePath = "".obs;

  void getImage() async {
    final pickedFile = await picker.value.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
    }
  }

  @override
  void onInit() {
    products.value = [];
    fetchProducts();
    super.onInit();
  }

  fetchProducts() async {
    ProductDatabaseHelper.db
        .getProductList()
        .then((productList) => {products.value = productList});
  }

  void addProduct(Product product) {
    if (product.id != null) {
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
        name: nameController.value.text,
        description: descriptionController.value.text,
        price: double.parse(priceController.value.text),
        image: imagePath.value,
      );
      addProduct(product);
    } else {
      var product = Product(
        name: nameController.value.text,
        description: descriptionController.value.text,
        price: double.parse(priceController.value.text),
        image: imagePath.value,
      );
      addProduct(product);
    }
    nameController.value.text = "";
    descriptionController.value.text = "";
    priceController.value.text = "";
    imagePath.value = "";
  }

  @override
  void onClose() {
    ProductDatabaseHelper.db.close();
    super.onClose();
  }
}
