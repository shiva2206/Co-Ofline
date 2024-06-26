import 'dart:collection';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseStorage _storage = FirebaseStorage.instance;

class ShopData
{
  String shop_name;
  String address;
  Uint8List file;
  double latitude;
  double longitude;
  String startingYear;
  String shop_upi;
  List<String> sub_category;

  ShopData({
    required this.shop_name,
    required this.address,
    required this.file,
    required this.latitude,
    required this.longitude,
    required this.startingYear,
    required this.shop_upi,
    required this.sub_category,
  });


}