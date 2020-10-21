import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:getx_sqflite/views/shopping_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
       primaryColor: Colors.teal.shade600,
      ),
      title: 'My Shopp App',
     home: ShoppingPage(),
    );
  }
}
