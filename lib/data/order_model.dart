import 'package:latlong2/latlong.dart';

class OrderModel {
  final String id;
  final String storeName;
  final String storeLogo;
  final String dishName;
  final String customerName;
  final String customerPhone;
  final String address;
  final String riderName;
  final String riderAvatar;
  final String price;
  final String time;
  final String status;
  final String cityName;
  final LatLng centerLatLng;
  final LatLng storeLatLng;
  final LatLng riderLatLng;
  final LatLng customerLatLng;
  final List<LatLng> routePoints;

  const OrderModel({
    required this.id,
    required this.storeName,
    required this.storeLogo,
    required this.dishName,
    required this.customerName,
    required this.customerPhone,
    required this.address,
    required this.riderName,
    required this.riderAvatar,
    required this.price,
    required this.time,
    required this.status,
    required this.cityName,
    required this.centerLatLng,
    required this.storeLatLng,
    required this.riderLatLng,
    required this.customerLatLng,
    required this.routePoints,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id']?.toString() ?? '',
      storeName: json['store']?.toString() ?? json['storeName']?.toString() ?? '',
      storeLogo: json['logo']?.toString() ?? json['storeLogo']?.toString() ?? '',
      dishName: json['dish']?.toString() ?? json['dishName']?.toString() ?? '',
      customerName: json['customer']?.toString() ?? json['customerName']?.toString() ?? '',
      customerPhone: json['customerPhone']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      riderName: json['rider']?.toString() ?? json['riderName']?.toString() ?? '',
      riderAvatar: json['avatar']?.toString() ?? json['riderAvatar']?.toString() ?? '',
      price: json['price']?.toString() ?? '',
      time: json['time']?.toString() ?? '',
      status: json['status']?.toString() ?? 'Pending',
      cityName: json['cityName']?.toString() ?? '',
      centerLatLng: _parseLatLng(json['centerLatLng'], const LatLng(14.8560, 120.8190)),
      storeLatLng: _parseLatLng(json['storeLatLng'], const LatLng(14.8527, 120.8160)),
      riderLatLng: _parseLatLng(json['riderLatLng'], const LatLng(14.8565, 120.8164)),
      customerLatLng: _parseLatLng(json['customerLatLng'], const LatLng(14.8581, 120.8242)),
      routePoints: _parseLatLngList(json['routePoints']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'store': storeName,
      'logo': storeLogo,
      'dish': dishName,
      'customer': customerName,
      'customerPhone': customerPhone,
      'address': address,
      'rider': riderName,
      'avatar': riderAvatar,
      'price': price,
      'time': time,
      'status': status,
      'cityName': cityName,
      'centerLatLng': [centerLatLng.latitude, centerLatLng.longitude],
      'storeLatLng': [storeLatLng.latitude, storeLatLng.longitude],
      'riderLatLng': [riderLatLng.latitude, riderLatLng.longitude],
      'customerLatLng': [customerLatLng.latitude, customerLatLng.longitude],
      'routePoints': routePoints.map((p) => [p.latitude, p.longitude]).toList(),
    };
  }

  static LatLng _parseLatLng(dynamic value, LatLng fallback) {
    if (value is LatLng) return value;
    if (value is List && value.length >= 2) {
      final double lat = double.tryParse(value[0].toString()) ?? fallback.latitude;
      final double lng = double.tryParse(value[1].toString()) ?? fallback.longitude;
      return LatLng(lat, lng);
    }
    return fallback;
  }

  static List<LatLng> _parseLatLngList(dynamic value) {
    if (value is List<LatLng>) return value;
    if (value is List) {
      final List<LatLng> result = [];
      for (var item in value) {
        if (item is LatLng) {
          result.add(item);
        } else if (item is List && item.length >= 2) {
          final double lat = double.tryParse(item[0].toString()) ?? 0.0;
          final double lng = double.tryParse(item[1].toString()) ?? 0.0;
          result.add(LatLng(lat, lng));
        }
      }
      if (result.isNotEmpty) return result;
    }
    return const [
      LatLng(14.8527, 120.8160),
      LatLng(14.8550, 120.8162),
      LatLng(14.8560, 120.8163),
      LatLng(14.8582, 120.8166),
      LatLng(14.8584, 120.8172),
      LatLng(14.8582, 120.8190),
      LatLng(14.8578, 120.8215),
      LatLng(14.8573, 120.8235),
      LatLng(14.8570, 120.8252),
    ];
  }
}
