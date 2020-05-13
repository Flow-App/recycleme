import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recycleme/config.dart';

import 'package:recycleme/entities/brand_entity.dart';
import 'package:recycleme/repos/normal_repo.dart';

class CollectRepo {
  static final Firestore db = Firestore.instance;
  Map<Category, String> categories = {
    Category.Plastic: 'plastic',
    Category.Glass: 'glass',
    Category.Tin: 'tin',
    Category.Battery: 'battery',
    Category.Paper: 'paper'
  };

  Future<bool> doIHavePendingLists() async {
    try {
      final userEnitiy = await NormalRepo().getCurrentUserProfile();
      final doc =
          await db.collection('pending_lists').document(userEnitiy.uid).get();

      return doc.exists;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<BrandEntity>> getUsersFavBrands(Category category) async {
    try {
      final user = await NormalRepo().getCurrentUserProfile();
      final docs = await db
          .collection('users')
          .document(user.uid)
          .collection('fav_brands')
          .where('category', isEqualTo: categories[category])
          .getDocuments();
      List<BrandEntity> list = [];

      if (docs.documents.length > 0) {
        docs.documents.forEach((doc) {
          list.add(BrandEntity(
              price: doc.data['price'],
              type: doc.data['type'],
              brandName: doc.data['brandName'],
              weight: doc.data['weight'],
              category: doc.data['category']));
        });
        Map<String, int> prices = await CollectRepo().getTypesAvrPrice();
        list.forEach((item) {
          item.price = double.parse(prices[item.type].toString());
        });
        return list;
      } else {
        return list;
      }
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  Future<List<BrandEntity>> getBrandsByCategory(
      {Category category, String name}) async {
    try {
      final docs = await db
          .collection('brands')
          .where('category', isEqualTo: categories[category])
          .where('brandName', isGreaterThanOrEqualTo: name)
          .getDocuments();
      List<BrandEntity> list = [];
      docs.documents.forEach((doc) {
        list.add(BrandEntity(
            price: doc.data['price'],
            type: doc.data['type'],
            brandName: doc.data['brandName'],
            weight: doc.data['weight'],
            category: doc.data['category']));
      });
      Map<String, int> prices = await CollectRepo().getTypesAvrPrice();
      list.forEach((item) {
        item.price = double.parse(prices[item.type].toString());
      });
      return list;
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  Future<Map<String, int>> getTypesAvrPrice() async {
    try {
      final doc = await db.collection('config').document('avg_prices').get();
      return {
        // TODO Cheke Types For One Last Time
        'PET': doc.data['PET'],
        'PP': doc.data['PP'],
        'PS': doc.data['PS'],
        'PVC': doc.data['PVC'],
        'HDPE': doc.data['HDPE'],
        'paper': doc.data['paper'],
        'glass': doc.data['glass'],
        'steel': doc.data['steel'],
        'aluminum': doc.data['aluminum'],
        'Battery1': doc.data['Battery1'],
        'Battery2': doc.data['Battery2'],
      };
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
}
