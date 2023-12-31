import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import '../../../../../core/globals.dart';
import 'package:sqflite/sqflite.dart';
import '../../../domain/use_cases/add_product_in_local_db_usecase.dart';
import '../../../domain/use_cases/apply_coupon_to_cart_usecase.dart';
import '../../models/cart_model.dart';

abstract class MyCartLocalDataSource {
  Future<int> addProduct(AddProductParams params);
  Future<int> deleteProduct(int id);
  Future<int> deleteAllProducts();
  Future<int> checkIfProductIsExitInDB(int id);
  Future<CartModel> getProductsFromLocaleDB();

}

class MyCartLocalDataSourceImpl implements MyCartLocalDataSource {
// Define a function that inserts dogs into the database
  @override
  Future<int> addProduct(AddProductParams params) async {
    /// Get a reference to the database.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    // print(params.toMap());
    await db.insert(
      'cart',
      params.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    if (kDebugMode) {
      print("File Add it in DATABASE");
    }
    final List<Map<String, dynamic>> maps = await db.query('cart');
    // print(maps);
    return 200;
  }

  @override
  Future<CartModel> getProductsFromLocaleDB() async {
    final db = await database;

    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM cart");


    CartModel cartModel =CartModel(carts:List<Cart>.from(maps.map((x) => Cart.fromJson(x))),);


    return cartModel;
  }


  @override
  Future<int> deleteProduct(int id)async {
    ///Get a reference to the database.
    final db = await database;
    ///Delete product from table.
    await db.rawQuery("DELETE  FROM cart WHERE id='$id'");
    return 200;
  }

  @override
  Future<int> checkIfProductIsExitInDB(int id) async {
    final db = await database;

    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM cart WHERE apiID='$id'");

    CartModel cartModel =CartModel(carts:List<Cart>.from(maps.map((x) => Cart.fromJson(x))),);

    if(cartModel.carts.isNotEmpty){
      return 200;
    }else{
      return 404;
    }

  }

  @override
  Future<int> deleteAllProducts()async {
    ///Get a reference to the database.
    final db = await database;
    ///Delete product from table.
    await db.rawQuery("DELETE  FROM cart");
    return 200;
  }


}
