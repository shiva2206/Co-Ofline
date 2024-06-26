import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co_ofline/screens/productScreen/Model/displayedProductModel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:co_ofline/utility/widgets/search/View/searchView.dart';
import 'package:co_ofline/utility/widgets/search/Model/searchModel.dart';

class ProductFirebase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Stream<List<ProductModel>> fetchProducts(String shopId, String searchText) {
    Query query =
        _firestore.collection('Shop').doc(shopId).collection('Product');
    if (searchText.isNotEmpty) {
      query = query
          .where('product_name', isGreaterThanOrEqualTo: searchText)
          .where('product_name', isLessThanOrEqualTo: searchText + '\uf8ff');
    }
    return query.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => ProductModel.fromFirestore(doc))
          .toList();
    });
  }

  Future<bool> updateStock(String shopId, String productId, bool status) async {
    try {
      DocumentReference productRef = _firestore
          .collection('Shop')
          .doc(shopId)
          .collection('Product')
          .doc(productId);

      await productRef.update({'inStock': !status});
      print('Product stock details updated');
      return true;
    } catch (e) {
      print('Failed to mark product : $e');
      return false;
    }
  }

  Future<bool> deleteProduct(String shopId, String productId) async {
    try {
      DocumentReference productRef = _firestore
          .collection('Shop')
          .doc(shopId)
          .collection('Product')
          .doc(productId);
      DocumentSnapshot doc = await productRef.get();
      String imagePath;
      if (doc.exists) {
        String imageUrl = doc.get('productImageLink');
        Uri uri = Uri.parse(imageUrl);
        imagePath = uri.pathSegments.join('/');
        print(imagePath);

        Reference ref = _storage.ref().child(imagePath);
        await ref.delete();
        print("Image deleted");
      }
      await productRef.delete();

      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }
}

// The repository provider does not need shopId as it doesn't depend on it
final productRepositoryProvider = Provider<ProductFirebase>((ref) {
  return ProductFirebase();
});

// The product list provider requires the shopId to fetch the products
final productListProvider =
    StreamProvider.family<List<ProductModel>, String>((ref, shopId) {
  final productRepository = ref.watch(productRepositoryProvider);
  final searchText = ref.watch(searchTextProvider);
  return productRepository.fetchProducts(shopId, searchText);
});

//Update Stock details

final updateStatusProvider =
    FutureProvider.family<bool, UpdateStockParams>((ref, params) {
  final productRepository = ref.watch(productRepositoryProvider);
  return productRepository.updateStock(
      params.shopId, params.productId, params.status);
});

final deleteProductProvider =
    FutureProvider.family<bool, UpdateStockParams>((ref, params) {
  final productRepository = ref.watch(productRepositoryProvider);
  return productRepository.deleteProduct(params.shopId, params.productId);
});
