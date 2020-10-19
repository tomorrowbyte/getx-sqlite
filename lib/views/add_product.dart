import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_sqflite/controllers/product_controller.dart';
import 'package:getx_sqflite/models/product.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  var shoppingController = Get.put(ShoppingController());
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();

  void addProduct(){
    var product = Product(productName: nameController.text, productDescription: descriptionController.text, price: double.parse(priceController.text));
    shoppingController.addProduct(product);
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.teal.shade600,
        body: Center(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
                child: TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.shop),
                    hintText: "Name",
                  ),
                  controller: nameController,
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
                  ),
                  controller: descriptionController,
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
                  ),
                  controller: priceController,
                ),
              ),
              RaisedButton(
                color: Colors.blue.shade700,
                child: Text("Add Product"),
                onPressed: () {
                  addProduct();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
