import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co_ofline/screens/productScreen/Model/addProductModel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../Model/displayedProductModel.dart';

final firestoreServiceProvider = Provider((ref) => FirestoreService());
class FirestoreService{
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    try {
      Reference ref = _storage.ref(childName);
      UploadTask uploadTask = ref.putData(file);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      //handle error
      print('Error uploading image:$e');
      throw Exception('Error uploading image');
    }
  }

  Future<void> addProduct(String shopId, Product product) async {
    try {
      // Upload the image first and get the download URL
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd;HH:mm:ss').format(now);
      String imageUrl = await uploadImageToStorage('products/${product.productName.replaceAll(' ', '_')+"_"+formattedDate}', product.file!);

      // Create a map of product data to be stored in Firestore
      Map<String, dynamic> productData = product.toMap();
      productData['productImageLink'] = imageUrl;

      // Add the product data to Firestore
      await _db
          .collection('Shop')
          .doc(shopId)
          .collection('Product')
          .add(productData)
          .then((documentSnapshot) => print('Product added with ID: ${documentSnapshot.id}'));
    } catch (e) {
      print('Error adding product: $e');
      throw e;
    }
  }
  Future<List<String>> getSubCategories(String shopId) async {
    try {
      DocumentSnapshot documentSnapshot = await _db
          .collection('Shop')
          .doc(shopId)
          .get();

      if (documentSnapshot.exists) {
        List<dynamic> subCategoriesDynamic = documentSnapshot['sub_category'];
        List<String> subCategories = subCategoriesDynamic.cast<String>();
        return subCategories;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}

final addProductProvider = FutureProvider.family<void, Product>((ref, product) async {
  final firestoreService = ref.read(firestoreServiceProvider);
  String shopId = 'E6nfYosnGIWZPGObjNqX';
  await firestoreService.addProduct(shopId, product);
});

final getCategoriesProvider = FutureProvider.family<List<String>, String>((ref, shopId) async {
  final firestoreService = ref.read(firestoreServiceProvider);
  return await firestoreService.getSubCategories(shopId);
});
