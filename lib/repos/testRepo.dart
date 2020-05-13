import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recycleme/entities/UserEntity.dart';
import 'package:recycleme/entities/brand_entity.dart';
import 'package:recycleme/main.dart';
import 'package:recycleme/repos/normal_repo.dart';

class TestRepo {
  final db = Firestore.instance;

  void insertDummyCp() async {
    print('started');
    for (int i = 0; i < 7; i++) {
      print(' $i  insertDummyCp started');
      final docRef = db.collection('users').document(i.toString());
      await docRef.setData({
        'uid': '${i.toString()}',
        'email': '${i.toString()}@mail.com',
        'nameOfCompany': '${i.toString()} company name ',
        'nameOfOwner': '${i.toString()} onwer name ',
        'city': '${i.toString()}  city',
        'district': '${i.toString()} district',
        'street': '${i.toString()}  street',
        'buildingNO': '${i.toString()} building no',
        'zipCode': '${i.toString()} zip code',
        'status': 'approved',
        'phoneNo': '${i.toString()} ',
        'role': 'cp',
        'lat':'36.562161',
        'long':'12.85796541',
        // TODO Fix Types
        'prices': {
          'PP': i + 1,
          'PS': i + 2,
          'PVC': i + 3,
          'HDPE': i + 4,
          'paper': i + 5,
          'glass': i + 6,
          'PET': i + 6,
          'steel': i + 7,
          'aluminum': i + 8,
          'battery1': i + 9,
          'battery2': i + 10,
        }
      });
      print(' $i done ');
    }
  }

  void insertDummyBrands() async {
    print('started');
    List<BrandEntity> cats = [
      BrandEntity(
          brandName: 'Coca Cola 1L',
          type: 'PET',
          weight: 16,
          category: 'plastic'),
      BrandEntity(
          brandName: 'Soda can', type: 'PET', weight: 17, category: 'plastic'),
      BrandEntity(
          brandName: 'bearn can', type: 'PET', weight: 18, category: 'plastic'),
      BrandEntity(
          brandName: 'shambo bottle',
          type: 'PP',
          weight: 18,
          category: 'plastic'),
      BrandEntity(
          brandName: 'walmart bag',
          type: 'PS',
          weight: 19,
          category: 'plastic'),
      BrandEntity(
          brandName: 'clear 250 ml ',
          type: 'PP',
          weight: 20,
          category: 'plastic'),
      BrandEntity(
          brandName: 'sprite can',
          type: 'PVC',
          weight: 21,
          category: 'plastic'),
      BrandEntity(
          brandName: 'tangled toy',
          type: 'HDPE',
          weight: 22,
          category: 'plastic'),
      BrandEntity(
          brandName: 'a5', type: 'paper', weight: 33, category: 'paper'),
      BrandEntity(
          brandName: 'a4', type: 'paper', weight: 34, category: 'paper'),
      BrandEntity(
          brandName: 'a3', type: 'paper', weight: 35, category: 'paper'),
      BrandEntity(
          brandName: 'a2', type: 'paper', weight: 36, category: 'paper'),
      BrandEntity(
          brandName: 'g1', type: 'glass', weight: 37, category: 'glass'),
      BrandEntity(
          brandName: 'g2', type: 'glass', weight: 38, category: 'glass'),
      BrandEntity(
          brandName: 'g3', type: 'glass', weight: 39, category: 'glass'),
      BrandEntity(
          brandName: 'g4', type: 'glass', weight: 40, category: 'glass'),
      BrandEntity(
          brandName: 'g5', type: 'glass', weight: 41, category: 'glass'),
      BrandEntity(
          brandName: 'asdsa ', type: 'steel', weight: 49, category: 'Tin'),
      BrandEntity(
          brandName: 'Aluaminasdasdum',
          type: 'aluminum',
          weight: 50,
          category: 'Tin'),
      BrandEntity(
          brandName: 'battery fdfdadfa',
          type: 'battery1',
          weight: 61,
          category: 'Battery'),
      BrandEntity(
          brandName: 'battery battery',
          type: 'battery2',
          weight: 62,
          category: 'Battery'),
    ];
    for (int index = 0; index < cats.length; index++) {
      var i = cats[index];
      final docRef = db.collection('brands').document(i.brandName);
      await docRef.setData(i.toMap());
    }
  }

  void insertDummyFriends() async {
    print('started');
    for (int i = 0; i < 7; i++) {
      print(' $i  freind started');
      final docRef = db
          .collection('users')
          .document('9CkeWfNy33eqxc9Hd7KeCwFgVgK2')
          .collection('friends')
          .document(i.toString());
      await docRef.setData({'since': DateTime.now(), 'uid': i.toString()});
      print(' $i done ');
    }
  }

  void insertDummyAvvrgePrices() async {
    print('started');
    final docRef = db.collection('config').document('avg_prices');
    await docRef.setData({
      // TODO Cheke Types For One Last Time
      'PET': 21,
      'PP': 22,
      'PS': 23,
      'PVC': 24,
      'HDPE': 25,
      'paper': 26,
      'glass': 27,
      'steel': 28,
      'aluminum': 29,
      'Battery1': 30,
      'Battery2': 31,
    });
  }

  void deleteDummyDocuments() async {
    for (int i = 10; i < 30; i++) {
      print(' $i  userd start delete ');
      await db.collection('usesrs').document(i.toString()).delete();
      print('${i.toString()} deleted');
    }
  }

  Future<void> givemeDummyTransACtions() async {
    final docRef =
        db.collection('users').document('9CkeWfNy33eqxc9Hd7KeCwFgVgK2');
    await docRef.updateData({
      'ItemTransAction': [
        // plastic
        ItemTransAction(
                amount: 67,
                date: DateTime(2020, 4, 20),
                type: 'plastic',
                price: 176)
            .toMap(),
        ItemTransAction(
                amount: 34,
                date: DateTime(2020, 4, 19),
                type: 'plastic',
                price: 153)
            .toMap(),
        ItemTransAction(
                amount: 86,
                date: DateTime(2020, 4, 18),
                type: 'plastic',
                price: 155)
            .toMap(),
        ItemTransAction(
                amount: 67,
                date: DateTime(2020, 4, 21),
                type: 'plastic',
                price: 152)
            .toMap(),
        ItemTransAction(
                amount: 43,
                date: DateTime(2020, 4, 27),
                type: 'plastic',
                price: 16)
            .toMap(),
        ItemTransAction(
                amount: 52,
                date: DateTime(2020, 4, 22),
                type: 'plastic',
                price: 15)
            .toMap(),
        // paper
        ItemTransAction(
                amount: 35,
                date: DateTime(2020, 4, 20),
                type: 'paper',
                price: 176)
            .toMap(),
        ItemTransAction(
                amount: 142,
                date: DateTime(2020, 4, 19),
                type: 'paper',
                price: 153)
            .toMap(),
        ItemTransAction(
                amount: 25,
                date: DateTime(2020, 4, 18),
                type: 'paper',
                price: 155)
            .toMap(),
        ItemTransAction(
                amount: 254,
                date: DateTime(2020, 4, 21),
                type: 'paper',
                price: 152)
            .toMap(),
        ItemTransAction(
                amount: 75,
                date: DateTime(2020, 4, 27),
                type: 'paper',
                price: 16)
            .toMap(),
        ItemTransAction(
                amount: 13,
                date: DateTime(2020, 4, 22),
                type: 'paper',
                price: 15)
            .toMap(),
        //  tin
        ItemTransAction(
                amount: 18,
                date: DateTime(2020, 4, 20),
                type: 'tin',
                price: 176)
            .toMap(),
        ItemTransAction(
                amount: 72,
                date: DateTime(2020, 4, 19),
                type: 'tin',
                price: 153)
            .toMap(),
        ItemTransAction(
                amount: 60,
                date: DateTime(2020, 4, 18),
                type: 'tin',
                price: 155)
            .toMap(),
        ItemTransAction(
                amount: 88,
                date: DateTime(2020, 4, 21),
                type: 'tin',
                price: 152)
            .toMap(),
        ItemTransAction(
                amount: 22, date: DateTime(2020, 4, 27), type: 'tin', price: 16)
            .toMap(),
        ItemTransAction(
                amount: 20, date: DateTime(2020, 4, 22), type: 'tin', price: 15)
            .toMap(),
        // glass
        ItemTransAction(
                amount: 30,
                date: DateTime(2020, 4, 20),
                type: 'glass',
                price: 176)
            .toMap(),
        ItemTransAction(
                amount: 45,
                date: DateTime(2020, 4, 19),
                type: 'glass',
                price: 153)
            .toMap(),
        ItemTransAction(
                amount: 55,
                date: DateTime(2020, 4, 18),
                type: 'glass',
                price: 155)
            .toMap(),
        ItemTransAction(
                amount: 12,
                date: DateTime(2020, 4, 21),
                type: 'glass',
                price: 152)
            .toMap(),
        ItemTransAction(
                amount: 452,
                date: DateTime(2020, 4, 27),
                type: 'glass',
                price: 16)
            .toMap(),
        ItemTransAction(
                amount: 123,
                date: DateTime(2020, 4, 22),
                type: 'glass',
                price: 15)
            .toMap(),
        // battery
        ItemTransAction(
                amount: 50,
                date: DateTime(2020, 4, 20),
                type: 'battery',
                price: 176)
            .toMap(),
        ItemTransAction(
                amount: 18,
                date: DateTime(2020, 4, 19),
                type: 'battery',
                price: 153)
            .toMap(),
        ItemTransAction(
                amount: 25,
                date: DateTime(2020, 4, 18),
                type: 'battery',
                price: 155)
            .toMap(),
        ItemTransAction(
                amount: 10,
                date: DateTime(2020, 4, 21),
                type: 'battery',
                price: 152)
            .toMap(),
        ItemTransAction(
                amount: 45,
                date: DateTime(2020, 4, 27),
                type: 'battery',
                price: 16)
            .toMap(),
        ItemTransAction(
                amount: 12,
                date: DateTime(2020, 4, 22),
                type: 'battery',
                price: 15)
            .toMap(),
      ]
    });
  }

  void insertUserDummyFavBrands() async {
    print('started');
    List<BrandEntity> cats = [
      BrandEntity(
          brandName: 'Coca Cola 1L',
          type: 'PET',
          weight: 16,
          category: 'plastic'),
      BrandEntity(
          brandName: 'Soda can', type: 'PET', weight: 17, category: 'plastic'),
      BrandEntity(
          brandName: 'bearn can', type: 'PET', weight: 18, category: 'plastic'),
      BrandEntity(
          brandName: 'shambo bottle',
          type: 'PP',
          weight: 18,
          category: 'plastic'),
      BrandEntity(
          brandName: 'walmart bag',
          type: 'PS',
          weight: 19,
          category: 'plastic'),
      BrandEntity(
          brandName: 'tangled toy',
          type: 'HDPE',
          weight: 22,
          category: 'plastic'),
      BrandEntity(
          brandName: 'a5', type: 'paper', weight: 33, category: 'paper'),
      BrandEntity(
          brandName: 'a4', type: 'paper', weight: 34, category: 'paper'),
      BrandEntity(
          brandName: 'g5', type: 'glass', weight: 41, category: 'glass'),
      BrandEntity(
          brandName: 'asdsa ', type: 'steel', weight: 49, category: 'Tin'),
      BrandEntity(
          brandName: 'Aluaminasdasdum',
          type: 'aluminum',
          weight: 50,
          category: 'Tin'),
      BrandEntity(
          brandName: 'battery fdfdadfa',
          type: 'battery1',
          weight: 61,
          category: 'Battery'),
      BrandEntity(
          brandName: 'battery battery',
          type: 'battery2',
          weight: 62,
          category: 'Battery'),
    ];
    for (int index = 0; index < cats.length; index++) {
      var i = cats[index];
      final user = await NormalRepo().getCurrentUserProfile();
      final docRef = db
          .collection('users')
          .document(user.uid)
          .collection('fav_brands')
          .document(i.brandName);
      await docRef.setData(i.toMap());
    }
  }
}
