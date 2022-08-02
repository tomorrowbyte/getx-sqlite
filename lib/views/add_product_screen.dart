import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_sqflite/controllers/product_controller.dart';

class AddProductScreen extends StatelessWidget {
  final shoppingController = Get.put(ShoppingController());

  void onAddProductScreenPress() {
    if (Get.arguments != null) {
      shoppingController.handleAddButton(Get.arguments.id);
    } else {
      shoppingController.handleAddButton();
    }

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    if (Get.arguments != null) {
      var args = Get.arguments;
      print(args);
      shoppingController.nameController.text = args.name;
      shoppingController.descriptionController.text = args.description;
      shoppingController.priceController.text = args.price.toString();
      shoppingController.imagePath = args.image;
    }
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
                  hintText: "Name".tr,
                  border: OutlineInputBorder(),
                ),
                controller: shoppingController.nameController,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
              child: TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  icon: Icon(Icons.description),
                  hintText: "Description".tr,
                  border: OutlineInputBorder(),
                ),
                controller: shoppingController.descriptionController,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  icon: Icon(Icons.monetization_on_rounded),
                  hintText: "Price".tr,
                  border: OutlineInputBorder(),
                ),
                controller: shoppingController.priceController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 10,
              ),
              child: TextButton.icon(
                icon: Icon(Icons.add_photo_alternate),
                label: FittedBox(
                  child: Obx(
                    () => Text(
                      shoppingController.imagePath == ""
                          ? "Select Image".tr
                          : shoppingController.imagePath.substring(44),
                    ),
                  ),
                ),
                onPressed: shoppingController.getImage,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  // color: Colors.blue.shade700,
                  child: Text(
                    "Add Product".tr,
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: onAddProductScreenPress,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
