import 'dart:collection';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseStorage _storage = FirebaseStorage.instance;

class ShopData {
  Future<String> uploadImageToStorage(String childName, Uint8List file) async {

    try {
      Reference ref = _storage.ref(childName);
      UploadTask uploadTask = ref.putData(file);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;

    } catch(e){
      //handle error
      debugPrint('Error uploading image:$e');
      throw Exception('Error uploading image');

    }


  }

  Future<String?> saveData({
    required String shop_name,
    required String address,
    required Uint8List file,
    required double latitude,
    required double longitude,
    required String startingYear,
    required String shop_upi,
    required List<String> sub_category,

  })

  async {
   

    try {
      // Get the current user
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        throw Exception('No user signed in');
      }

      if (shop_name.isNotEmpty ||
          address.isNotEmpty ||
          startingYear.isNotEmpty ||
          shop_upi.isNotEmpty ||
          sub_category.isNotEmpty
          ){
        String imageUrl = await uploadImageToStorage('shopImage', file);

       DocumentReference shopDocRef = await _firestore.collection('Shop').add({
        'shop_name': shop_name.toLowerCase(),
        'address': address.toLowerCase(),
        'startingYear': startingYear.toLowerCase(),
        'shop_upi': shop_upi.toLowerCase(),
        'sub_category': sub_category.map((e)=> e.toLowerCase()).toList(),
        'shopImageLink': imageUrl,
        'location': GeoPoint(latitude, longitude),
        'owner': currentUser.email,
        'total_order': 0, // Default value
        'total_amount': 0.0, // Default value
        'fav_count': 0, // Default value
        'views': 0, // Default value
        'live_view': 0, // Default value
        'isOpen':false,
        'isActivated':false
      });
      
      return shopDocRef.id;
    
      } 
      

    }
    catch (err) {
     
      debugPrint('Error saving data: $err');
    }
    return null;
  }
}
