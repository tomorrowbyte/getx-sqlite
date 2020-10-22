import 'dart:io';

import 'package:getx_sqflite/models/product.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ProductDatabaseHelper {
  static Database _productDb;
  static ProductDatabaseHelper _productDatabaseHelper;

  String table = 'productTable';
  String cartTable = 'cartTable';
  String colId = 'id';
  String colName = 'productName';
  String colDescription = "productDescription";
  String colPrice = "price";

  ProductDatabaseHelper._createInstance();

  static final ProductDatabaseHelper db =
      ProductDatabaseHelper._createInstance();

  factory ProductDatabaseHelper() {
    if (_productDatabaseHelper == null) {
      _productDatabaseHelper = ProductDatabaseHelper._createInstance();
    }
    return _productDatabaseHelper;
  }

  Future<Database> get database async {
    if (_productDb == null) {
      _productDb = await initializeDatabase();
    }
    return _productDb;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'products.db';
    var myDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return myDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute("CREATE TABLE $table"
        "($colId INTEGER PRIMARY KEY AUTOINCREMENT,"
        "$colName TEXT, $colDescription TEXT, $colPrice TEXT)");
    await db.execute('CREATE TABLE $cartTable'
        "($colId INTEGER PRIMARY KEY AUTOINCREMENT,"
        "$colName TEXT, $colDescription TEXT, $colPrice TEXT)");
  }

  Future<List<Map<String, dynamic>>> getProductMapList() async {
    Database db = await this.database;
    var result = await db.query(table, orderBy: "$colId ASC");
    return result;
  }

  Future<List<Map<String, dynamic>>> getCartMapList() async {
    Database db = await this.database;
    var result = await db.query(cartTable, orderBy: "$colId ASC");
    return result;
  }

  Future<int> insertProduct(Product product, {cart = false}) async {
    // print(cart);
    Database db = await this.database;
    var result = await db.insert(cart ? cartTable : table, product.toMap());
    print(result);
    return result;
  }

  Future<int> updateProduct(Product product, {cart = false}) async {
    // print("updating task ${task.id} ${task.name} current status ${task.completed}");
    var db = await this.database;
    var result = await db.update(cart ? cartTable : table, product.toMap(),
        where: '$colId = ?', whereArgs: [product.id]);
    return result;
  }

  Future<int> deleteProduct(int id, {cart = false}) async {
    print("Deleting Product with id: $id ");
    var db = await this.database;
    int result = await db
        .delete(cart ? cartTable : table, where: '$colId = ?', whereArgs: [id]);
    print("Delete result: $result");
    return result;
  }

  Future<int> getCount(tableName) async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $tableName');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Product>> getProductList() async {
    var productMapList = await getProductMapList();
    int count = await getCount(table);

    List<Product> productList = List<Product>();
    for (int i = 0; i < count; i++) {
      productList.add(Product.fromMap(productMapList[i]));
    }
    return productList;
  }

  Future<List<Product>> getCartProductList() async {
    var productMapList = await getCartMapList();
    int count = await getCount(cartTable);

    List<Product> productList = List<Product>();
    for (int i = 0; i < count; i++) {
      productList.add(Product.fromMap(productMapList[i]));
    }
    return productList;
  }

  close() async {
    var db = await this.database;
    var result = db.close();
    return result;
  }
}
