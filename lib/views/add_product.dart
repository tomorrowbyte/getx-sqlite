import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_sqflite/controllers/product_controller.dart';
// import 'package:getx_sqflite/models/product.dart';

class AddProduct extends StatelessWidget {
  final shoppingController = Get.put(ShoppingController());
  void onAddProductPress() {
    shoppingController.handleAddButton();
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: ListView(
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
              child: TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.title_rounded),
                  hintText: "Name",
                  border: OutlineInputBorder(),
                ),
                controller: shoppingController.nameController.value,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
              child: TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  icon: Icon(Icons.description),
                  hintText: "Description",
                  border: OutlineInputBorder(),
                ),
                controller: shoppingController.descriptionController.value,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  icon: Icon(Icons.monetization_on_rounded),
                  hintText: "Price",
                  border: OutlineInputBorder(),
                ),
                controller: shoppingController.priceController.value,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
              child: FlatButton.icon(
                icon: Icon(Icons.add_photo_alternate),
                label: Text("Select Image"),
                onPressed: shoppingController.getImage,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  color: Colors.blue.shade700,
                  child: Text(
                    "Add Product",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: onAddProductPress,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
