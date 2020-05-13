
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recycleme/entities/CPEntity.dart';
import 'package:recycleme/entities/DealEntity.dart';
import 'package:recycleme/entities/ListItemEntity.dart';

import 'package:recycleme/entities/brand_entity.dart';
import 'package:recycleme/repos/normal_repo.dart';

class DealsRepo {
  static final Firestore db = Firestore.instance;

  Future<List<DealEntity>> getUserDeals() async {
    try {
      final user = await NormalRepo().getCurrentUserProfile();
      final docs = await db.collection('deals').where(
          'uid', isEqualTo: user.uid).getDocuments();
      List<DealEntity> deals = [];
      docs.documents.forEach((doc) {
        List<ListItemEntity> dealItemsList = [];
        for (int i = 0; i < doc.data['items'].length; i++) {
          dealItemsList.add(ListItemEntity(
              quntity: doc.data['items'][i]['quntity'],
              brand: BrandEntity(
                  category: doc.data['items'][i]['itemCategory'],
                  weight: doc.data['items'][i]['itemWeight'],
                  type: doc.data['items'][i]['itemType'],
                  brandName: doc.data['items'][i]['itemName'],
                  price: doc.data['items'][i]['itemaPrice']
              )
          ));
        }
        DealStatus status ;
        switch (doc.data['status']) {
          case 'in_process':
            status = DealStatus.in_process;
            break;
          case 'accepted':
            status = DealStatus.accepted;
            break;
          case 'rejected':
            status = DealStatus.rejected;
            break;
          case 'done':
            status = DealStatus.done;
            break;
        }
        deals.add(DealEntity(
          date: DateTime.fromMillisecondsSinceEpoch(
              doc.data['date'].millisecondsSinceEpoch),
          status
          :status,
          cpID: doc.data['cp_id'],
          cpName: doc.data['cpName'] == null ? 'null :D' : doc.data['cpName'],
          uid: doc.data['uid'],
          dealItems: dealItemsList,
        ));
      });
      return deals;
    } catch (e) {
      print(e);
      print(e.runtimeType);

      return Future.error(e);
    }
  }

  Future<bool> makeAdeal({List<ListItemEntity> items, CPEntity cp}) async {
    try {
      final user = await NormalRepo().getCurrentUserProfile();
      final DateTime date = DateTime.now();

      List<Map<String, dynamic>> itemsMap = [];
      items.forEach((item) {
        itemsMap.add({
          'itemName': item.brand.brandName,
          'quntity': item.quntity,
          'itemType': item.brand.type,
          'itemWeight': item.brand.weight,
          'itemCategory': item.brand.category,
          'itemaPrice': item.brand.price
        });
      });
      await db.collection('deals').document(
          ('${user.uid}${date.millisecondsSinceEpoch}')).setData({
        'cp_id': cp.uid,
        'cpName': cp.nameOfCompany,
        'uid': user.uid,
        'status': 'in_process',
        'date': date,
        'items': itemsMap
      });
      return true;
    } catch (e) {
      print(e);
      print('errrrrrrrrrrrrrrrrrrrrrrrrrrrr');
      return false;
    }
  }
}
