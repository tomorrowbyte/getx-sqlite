import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  controller: nameController,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
                child: TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.monetization_on_rounded),
                    hintText: "Price",
                  ),
                  controller: nameController,
                ),
              ),
              RaisedButton(
                color: Colors.blue.shade400,
                child: Text("Add Product"),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
