import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:getx_sqflite/utils/localization_service.dart';
import 'package:getx_sqflite/views/product_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: LocalizationService.locale,
      fallbackLocale: LocalizationService.fallBackLocale,
      translations: LocalizationService(),
      theme: ThemeData(
        primaryColor: Colors.teal.shade600,
      ),
      darkTheme: ThemeData.dark(),
      title: 'My Shopp App',
      home: ProductListScreen(),
    );
  }
}
