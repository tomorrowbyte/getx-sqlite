import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_sqflite/controllers/cart_controller.dart';
import 'package:getx_sqflite/controllers/product_controller.dart';
import 'package:getx_sqflite/models/product.dart';
import 'package:getx_sqflite/views/add_product_screen.dart';
import 'package:getx_sqflite/views/cart_screen.dart';
import 'package:getx_sqflite/views/my_drawer.dart';

class ProductListScreen extends StatelessWidget {
  final controller = Get.put(ShoppingController());
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          // title property shows search field or app title
          title: Obx(
            () => controller.showSearchField.value
                ? Text("title".tr)
                : TextField(
                    onChanged: (text) {
                      if (text.length == 1) {
                        Get.snackbar(
                          "Error!",
                          "This part is not implemented yet!",
                          icon: Icon(Icons.error, color: Colors.red),
                        );
                      }
                    },
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      icon: Icon(Icons.search_rounded),
                      labelText: "Search".tr,
                    ),
                  ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              // Obx handles change event, and listens to changes then set the new
              // state based on the changed state.
              icon: Obx(() {
                return Icon(
                  controller.showSearchField.value == true
                      ? Icons.search_off
                      : Icons.search,
                );
              }),
              onPressed: controller.toggleShowSearch,
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => Get.to(AddProductScreen()),
            )
          ],
        ),
        drawer: MyDrawer(),
        body: Column(
          children: [
            ProductList(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Total Amount".tr,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Text(
                  ": \$ ${cartController.totalPrice.toPrecision(2)}",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 100),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(CartItemsScreen());
            if (controller.showSearchField.isTrue) {
              controller.toggleShowSearch();
            }
          },
          label: Obx(() => Text('${cartController.count} cart items')),
          icon: Icon(Icons.shopping_cart_outlined),
        ),
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  const ProductList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShoppingController shoppingController = Get.find();
    List products = shoppingController.products;
    return Obx(() {
      return Expanded(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ListCartItem(product: products[index]);
          },
          itemCount: products.length,
        ),
      );
    });
  }
}

class ListCartItem extends StatelessWidget {
  const ListCartItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    CartController controller = Get.find();
    ShoppingController shoppingController = Get.find();
    return Dismissible(
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.delete,
          size: 50,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        shoppingController.deleteProduct(product);

        Get.snackbar(
          "${product.name} Deleted!",
          "",
          icon: Icon(Icons.message),
          onTap: (_) {},
          barBlur: 20,
          isDismissible: true,
          duration: Duration(seconds: 2),
        );
      },
      key: UniqueKey(),
      child: GestureDetector(
        onDoubleTap: () {
          // Open existing Product item  in Add New Product Screen.
          // Get.to(
          //   AddProductScreen(),
          //   arguments: controller.product,
          // );
        },
        child: Card(
          margin: const EdgeInsets.all(12),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (product.image.isNotEmpty)
                      Image.file(
                        File(product.image),
                        width: 64.0,
                        height: 64.0,
                        fit: BoxFit.cover,
                      ),
                    Text(
                      "\$${product.price}",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${product.name}",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        controller.addToCart(product);
                      },
                      icon: Icon(Icons.add_shopping_cart),
                      label: Text("Add to Cart".tr),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
