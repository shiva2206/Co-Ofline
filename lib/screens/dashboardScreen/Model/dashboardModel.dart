import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';

class ShopModel {
  final String id;
  final String shop_name;
  final String shopImageLink;
  final String address;
  final double latitude;
  final double longitude;
  final String startingYear;
  final int live_views;
  final double fav_count;
  final double views;
  final double total_amount;
  final double total_order;

  ShopModel({
    required this.id,
    required this.shop_name,
    required this.shopImageLink,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.startingYear,
    required this.fav_count,
    required this.views,
    required this.live_views,
    required this.total_amount,
    required this.total_order,

  });

  factory ShopModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final geopoint = data['location'] as GeoPoint;
    return ShopModel(
      id: doc.id,
      shop_name: data['shop_name'],
      shopImageLink: data['shopImageLink'],
      address: data['address'],
      startingYear: data['startingYear'],
      latitude: geopoint.latitude,
      longitude: geopoint.longitude,
      live_views: data['live_view'],
      views: data['views'].toDouble(),
      total_amount: data['total_amount'].toDouble(),
      fav_count: data['fav_count'].toDouble(),
      total_order: data['total_order'].toDouble(),

    );
  }
}

