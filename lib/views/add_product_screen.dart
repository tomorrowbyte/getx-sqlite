import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_sqflite/controllers/product_controller.dart';

class AddProductScreen extends StatelessWidget {
  final controller = Get.put(ShoppingController());

  void onAddProductScreenPress() {
    if (Get.arguments != null) {
      controller.handleAddButton(Get.arguments.id);
    } else {
      controller.handleAddButton();
    }

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    if (Get.arguments != null) {
      final args = Get.arguments;
      controller.nameController.text = args.name;
      controller.descriptionController.text = args.description;
      controller.priceController.text = args.price.toString();
      controller.imagePath = args.image;
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
                  border: UnderlineInputBorder(),
                ),
                controller: controller.nameController,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
              child: TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.description),
                  hintText: "Description".tr,
                  border: UnderlineInputBorder(),
                ),
                controller: controller.descriptionController,
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
                  border: UnderlineInputBorder(),
                ),
                controller: controller.priceController,
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
                  child: Text(
                    controller.imagePath.isEmpty
                        ? "Pick Image"
                        : controller.imagePath.substring(0, 44),
                  ),
                ),
                onPressed: controller.pickImage,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text(
                    "Add Product".tr,
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
