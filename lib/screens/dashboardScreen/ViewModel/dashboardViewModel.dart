import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co_ofline/screens/dashboardScreen/Model/dashboardModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShopFirebase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<ShopModel> fetchShopById(String shopId) {
    return _firestore.collection('Shop').doc(shopId).snapshots().map((snapshot) {
      return ShopModel.fromFirestore(snapshot);
    });
  }
}

final shopRepositoryProvider = Provider<ShopFirebase>((ref) {
  return ShopFirebase();
});

final shopProvider = StreamProvider.family<ShopModel, String>((ref, shopId) {
  final shopRepository = ref.watch(shopRepositoryProvider);
  return shopRepository.fetchShopById(shopId);
});
