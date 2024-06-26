import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Model/editProductModel.dart';

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

  Future<Product?> fetchProduct(String shopId, String productId) async {
    final docSnapshot = await _db
        .collection('Shop')
        .doc(shopId)
        .collection('Product')
        .doc(productId)
        .get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data();
      if (data != null) {
        return Product(
          productName: data['product_name'],
          sizeVariant: data['sizeVariant'],
          file: data['file'],
          subCategory: data['sub_category'],
          inStock: data['inStock'],
          isVeg: data['isVeg'],
        );
      }
    }
    return null;
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

final fetchProductProvider = FutureProvider.family<void, FetchProductParams>((ref, params) {
  final productRepository = ref.watch(firestoreServiceProvider);
  return productRepository.fetchProduct(params.shopId, params.productId);
});

final getCategoriesProvider = FutureProvider.family<List<String>, String>((ref, shopId) async {
  final firestoreService = ref.read(firestoreServiceProvider);
  return await firestoreService.getSubCategories(shopId);
});
