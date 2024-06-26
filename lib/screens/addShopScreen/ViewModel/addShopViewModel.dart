// import 'package:co_ofline/screens/addShopScreen/Model/editShopModel.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'dart:typed_data';
//
// class AddShopState {
//   final bool isLoading;
//   final String? successMessage;
//   final String? errorMessage;
//
//   AddShopState({
//     this.isLoading = false,
//     this.successMessage,
//     this.errorMessage,
//   });
//
//   AddShopState copyWith({
//     bool? isLoading,
//     String? successMessage,
//     String? errorMessage,
//   }) {
//     return AddShopState(
//       isLoading: isLoading ?? this.isLoading,
//       successMessage: successMessage,
//       errorMessage: errorMessage,
//     );
//   }
// }
//
// class AddShopViewModel extends StateNotifier<AddShopState> {
//   final ShopData _shopData = ShopData();
//
//   AddShopViewModel() : super(AddShopState());
//
//   Future<void> saveShopData({
//     required String shop_name,
//     required String address,
//     required Uint8List file,
//     required double latitude,
//     required double longitude,
//     required String startingYear,
//     required String shop_upi,
//     required List<String> sub_category,
//   }) async {
//     state = state.copyWith(isLoading: true, errorMessage: null, successMessage: null);
//
//     try {
//       await _shopData.saveData(
//         shop_name: shop_name,
//         address: address,
//         file: file,
//         latitude: latitude,
//         longitude: longitude,
//         startingYear: startingYear,
//         shop_upi: shop_upi,
//         sub_category: sub_category,
//       );
//       state = state.copyWith(isLoading: false, successMessage: "Shop data saved successfully!");
//     } catch (e, stackTrace) {
//       print('Error saving shop data: $e');
//       print('Error stack trace: $stackTrace');
//       state = state.copyWith(isLoading: false, errorMessage: e.toString());
//     }
//   }
// }
//
// final addShopViewModelProvider = StateNotifierProvider<AddShopViewModel, dynamic>((ref) {
//   return AddShopViewModel();
// });
