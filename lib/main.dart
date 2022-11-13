import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:getx_sqflite/utils/localization_service.dart';

import 'views/product_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: LocalizationService.locale,
      fallbackLocale: LocalizationService.fallBackLocale,
      translations: LocalizationService(),
      theme: ThemeData(
        primaryColor: Colors.teal,
        useMaterial3: true,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.teal,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        )),
        appBarTheme: AppBarTheme(
          actionsIconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      darkTheme: ThemeData.dark(),
      title: 'My Shopp App',
      home: ProductListScreen(),
    );
  }
}
