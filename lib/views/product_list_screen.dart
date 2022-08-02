import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_sqflite/controllers/cart_controller.dart';
import 'package:getx_sqflite/controllers/product_controller.dart';
// import 'package:getx_sqflite/utils/localization_service.dart';
import 'package:getx_sqflite/views/add_product_screen.dart';
import 'package:getx_sqflite/views/cart_screen.dart';
import 'package:getx_sqflite/views/my_drawer.dart';

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final shoppingController = Get.put(ShoppingController());
    final cartController = Get.put(CartController());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          // title property shows search field or app title
          title: shoppingController.showSearchField
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
          centerTitle: true,
          actions: [
            IconButton(
              // Obx handles change event, and listens to changes then set the new
              // state based on the changed state.
              icon: Icon(
                shoppingController.showSearchField
                    ? Icons.search_off
                    : Icons.search,
              ),
              onPressed: shoppingController.toggleShowSearch,
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => Get.to(AddProductScreen()),
            )
          ],
        ),
        drawer: MyDrawer(),
        backgroundColor: Colors.teal,
        body: Column(
          children: [
            ProductList(cartController: cartController),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Total Amount".tr,
                  style: TextStyle(fontSize: 32, color: Colors.white),
                ),
                Text(
                  ": \$ ${cartController.totalPrice.toPrecision(2)}",
                  style: TextStyle(fontSize: 32, color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 100),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(CartItemsScreen());
            if (shoppingController.showSearchField) {
              shoppingController.toggleShowSearch();
            }
          },
          label: Text(cartController.count.toString()),
          icon: Icon(Icons.shopping_cart_outlined),
        ),
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  const ProductList({
    Key key,
    @required this.cartController,
  }) : super(key: key);

  final CartController cartController;

  @override
  Widget build(BuildContext context) {
    final shoppingController = Get.put(ShoppingController());
    List products = shoppingController.products;
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
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
              shoppingController.deleteProduct(products[index]);

              Get.snackbar(
                "${products[index].name} Deleted!",
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
                //   arguments: controller.products[index],
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
                          Image.file(
                            File(products[index].image),
                            width: 64.0,
                            height: 64.0,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            "\$${products[index].price}",
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
                            "${products[index].name}",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              cartController.addToCart(products[index]);
                            },
                            // color: Colors.blue,
                            // textColor: Colors.white,
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
        },
        itemCount: products.length,
      ),
    );
  }
}
