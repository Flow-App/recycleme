import 'package:recycleme/repos/deals_rebo.dart';
import 'package:recycleme/repos/geo_rebo.dart';

import 'ListItemEntity.dart';

class CPEntity {
  final String uid;
  final String email;
  final String nameOfCompany;
  final String nameOfOwner;
  String lat;
  String long;
  String city;
  String district;
  String street;
  String buildingNO;
  String zipCode;
  String phoneNo;
  String status; //authStatus
  String workingHours;
  Map<String, double> prices;

  CPEntity({
    this.uid,
    this.email,
    this.status,
    this.nameOfCompany,
    this.nameOfOwner,
    this.prices,
    String lat,
    String long,
    String city,
    String district,
    String street,
    String buildingNO,
    String zipCode,
    String phoneNo,
  }) {
    const String un = 'n/a';
    this.city = city == null ? un : city;
    this.district = district == null ? un : district;
    this.street = street == null ? un : street;
    this.buildingNO = buildingNO == null ? un : buildingNO;
    this.zipCode = zipCode == null ? un : zipCode;
    this.phoneNo = phoneNo == null ? un : phoneNo;
    this.lat = lat == null ? un : lat;
    this.long = long == null ? un : long;
  }

  double getTotalItemsPrice(List<ListItemEntity> items) {
    double price = 0;
    items.forEach((item) {
      int count = item.quntity;
      price += (prices[item.brand.type] * item.brand.weight) * count;
    });

    return price / 1000;
  }

  Future<String> getDistanceBetweenUser() async {
    final double distance = await GeoRepo().getDistanceUserAndCp(double.parse(this.lat), double.parse(this.long));
    if (distance >= 1000) {
      String distanceString = distance
          .toStringAsFixed(distance.truncateToDouble() == distance ? 0 : 2);
      return '$distanceString km';
    }else {
      return '$distance meters';
    }

   }
  Future<double> getDistanceBetweenUserAsDouble() async {
    return await GeoRepo().getDistanceUserAndCp(double.parse(this.lat), double.parse(this.long));


  }
}
