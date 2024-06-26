import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'dart:typed_data';

class Product {
  String productName;
  Uint8List? file;

  Map<String, dynamic> sizeVariant;
  String subCategory;
  bool inStock;
  bool isVeg;
  int max_qty;
  int min_price;

  Product({
    required this.productName,
    required this.sizeVariant,
    required this.file,
    required this.subCategory,
    required this.inStock,
    required this.isVeg,
    required this.max_qty,
    required this.min_price
  });

  Map<String, dynamic> toMap() {
    return {
      'product_name': productName,
      'sizeVariant': sizeVariant,
      'sub_category': subCategory,
      'inStock': inStock,
      'isVeg' : isVeg,
      'max_qty' : max_qty,
      'min_price' : min_price
    };
  }
}
