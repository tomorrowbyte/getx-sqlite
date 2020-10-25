import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:getx_sqflite/views/product_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: Locale('fa', 'AF'),
      translationsKeys: {
        "fa_AF": {
          "title": 'سرای خرید',
          "Add to Cart": "اضافه کردن به سبد خرید",
          "Cart Items": "لیست خرید",
          "Total Amount": "مجموع قیمت",
          "Search": "جستجو",
        },
        "en_US": {
          "title": "Shopping App",
          "Add to Cart": "Add to Cart",
          "Cart Items": "Cart Items",
          "Total Amount": "Total Amount",
        }
      },
      theme: ThemeData(
        primaryColor: Colors.teal.shade600,
      ),
      title: 'My Shopp App',
      home: ProductListScreen(),
    );
  }
}
