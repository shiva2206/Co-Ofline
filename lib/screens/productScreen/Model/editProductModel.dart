import 'dart:typed_data';

class Product {
  String productName;
  Uint8List? file;
  Map<String, dynamic> sizeVariant;
  String subCategory;
  bool inStock;
  bool isVeg;

  Product({
    required this.productName,
    required this.sizeVariant,
    required this.file,
    required this.subCategory,
    required this.inStock,
    required this.isVeg
  });

  Map<String, dynamic> toMap() {
    return {
      'product_name': productName,
      'sizeVariant': sizeVariant,
      'sub_category': subCategory,
      'inStock': inStock,
      'isVeg' : isVeg,
    };
  }
}
class FetchProductParams {
  final String shopId;
  final String productId;
  FetchProductParams(this.shopId, this.productId);
}