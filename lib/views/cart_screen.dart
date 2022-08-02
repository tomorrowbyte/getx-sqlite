import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_sqflite/controllers/cart_controller.dart';
import 'package:photo_view/photo_view.dart';

class CartItemsScreen extends StatelessWidget {
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Cart Items".tr,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.delete_sweep_outlined),
              tooltip: "Delete".tr,
              onPressed: cartController.resetCart,
            ),
            IconButton(icon: Icon(Icons.add_shopping_cart), onPressed: () {}),
          ],
        ),
        body: GetX<CartController>(
          init: CartController(),
          builder: (controller) {
            return ListView.builder(
              itemCount: controller.cartItems.length,
              itemBuilder: (context, i) {
                var product = controller.cartItems[i];
                return Dismissible(
                  background: Container(
                    decoration: BoxDecoration(color: Colors.blue.shade700),
                  ),
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    controller.removeFromCart(product);
                    Get.snackbar("${product.name.toUpperCase()} Deleted", "");
                  },
                  child: ListTile(
                    leading: product.image != null && product.image != ""
                        ? GestureDetector(
                            child: Image.file(File(product.image)),
                            onTap: () {
                              Get.dialog(
                                SizedBox(
                                  width: Get.width - 10,
                                  height: Get.height - 20,
                                  child: PhotoView(
                                    initialScale:
                                        PhotoViewComputedScale.covered,
                                    minScale: 0.5,
                                    maxScale: 3.0,
                                    imageProvider: FileImage(
                                      File(product.image),
                                    ),
                                  ),
                                ),
                                useSafeArea: false,
                              );
                              print(product.image);
                            },
                          )
                        : Icon(Icons.dashboard_outlined),
                    title: Text(product.name),
                    subtitle: Text(product.description),
                    trailing: Text("\$ " + product.price.toString()),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
