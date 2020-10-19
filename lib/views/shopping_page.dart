import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_sqflite/controllers/cart_controller.dart';
import 'package:getx_sqflite/controllers/product_controller.dart';
import 'package:getx_sqflite/views/add_product.dart';

class ShoppingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final shoppingController = Get.put(ShoppingController());
    final cartController = Get.put(CartController());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Shopping App"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => Get.to(AddProduct()),
            )
          ],
        ),
        backgroundColor: Colors.teal,
        body: Column(
          children: [
            Expanded(
              child: GetX<ShoppingController>(
                builder: (controller) {
                  return ListView.builder(
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
                          controller.deleteProduct(controller.products[index]);
                          Get.showSnackbar(GetBar(
                            mainButton: FlatButton.icon(
                              onPressed: () {
                                // controller
                                //     .addProduct(controller.shouldDeleteProduct.value);
                              },
                              icon: Icon(Icons.undo, color: Colors.white),
                              label: Text("UNDO", style: TextStyle(color: Colors.white),),
                            ),
                            messageText: Text(
                                "${controller.products[index].productName} deleted!"),
                            icon: Icon(Icons.delete),
                            duration: Duration(seconds: 2),
                            title: "Delete",
                          ));
                        },
                        key: Key(controller.products[index].id.toString()),
                        child: Card(
                          margin: const EdgeInsets.all(12),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${controller.products[index].productName}",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      "\$${controller.products[index].price}",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    RaisedButton(
                                      onPressed: () {
                                        cartController.addToCart(
                                            controller.products[index]);
                                      },
                                      color: Colors.blue,
                                      textColor: Colors.white,
                                      child: Text("Add to Cart"),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: controller.products.length,
                  );
                },
              ),
            ),
            GetX<CartController>(
              init: CartController(),
              builder: (controller) {
                return Text(
                  "Total Amount: \$ ${controller.totalPrice.toPrecision(2)}",
                  style: TextStyle(fontSize: 32, color: Colors.white),
                );
              },
            ),
            SizedBox(height: 100),
          ],
        ),
        floatingActionButton: GetX<CartController>(
          init: CartController(),
          builder: (controller) {
            return FloatingActionButton.extended(
              onPressed: () {
                print("FAB Pressed");
              },
              label: Text(controller.count.toString()),
              icon: Icon(Icons.shopping_cart_outlined),
            );
          },
        ),
      ),
    );
  }
}
