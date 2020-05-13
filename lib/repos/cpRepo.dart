import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recycleme/entities/CPEntity.dart';

class CpRepo {
  static final Firestore db = Firestore.instance;

  Future<CPEntity> getCurrentCpProfile() async {
    try {
      CPEntity cp;
      final authResult = await FirebaseAuth.instance.currentUser();
      final snapShot =
          await db.collection('users').document(authResult.uid).get();
      cp = CPEntity(
        buildingNO: snapShot.data['buildingNO'],
        city: snapShot.data['city'],
        nameOfCompany: snapShot.data['nameOfCompany'],
        nameOfOwner: snapShot.data['nameOfOwner'],
        phoneNo: snapShot.data['phoneNo'],
        status: snapShot.data['status'],
        street: snapShot.data['street'],
        zipCode: snapShot.data['zipCode'],
        uid: snapShot.data['uid'],
        email: snapShot.data['email'],
        district: snapShot.data['district'],
        long: snapShot.data['long'],
        lat: snapShot.data['lat'],
      );

      return cp;
    } catch (e) {
      print(e);
      return Future.error('e');
    }
  }

  Future<List<CPEntity>> getApprovedCollectionPoints() async {
    try {
      final docs = await db
          .collection('users')
          .where('status', isEqualTo: 'approved')
          .where('role', isEqualTo: 'cp')
          .getDocuments();
      List<CPEntity> cps = [];
      docs.documents.forEach((doc) {
        final Map<String, dynamic> map = doc.data['prices'];
        final Map<String, double> prices = {};

        map.keys.toList().forEach((key) {
          prices[key] = double.parse(map[key].toString());
        });
//        print('pvc');
//        print(prices['PVC']);
//        print(prices);
        cps.add(CPEntity(
          buildingNO: doc.data['buildingNO'],
          city: doc.data['city'],
          nameOfCompany: doc.data['nameOfCompany'],
          nameOfOwner: doc.data['nameOfOwner'],
          phoneNo: doc.data['phoneNo'],
          status: doc.data['status'],
          street: doc.data['street'],
          zipCode: doc.data['zipCode'],
          uid: doc.data['uid'],
          email: doc.data['email'],
          district: doc.data['district'],
          long: doc.data['long'],
          lat: doc.data['lat'],
          // TODO Fix Types
          prices: prices,
        ));
      });
      return cps;
    } catch (e) {
      print(e);
      return Future.error('e');
    }
  }

  Future<void> sendEditProfileReq(Map<String, dynamic> data) async {
    try {
      final authResult = await FirebaseAuth.instance.currentUser();
      await db.collection('edit_req').document(authResult.uid).setData(data);
    } catch (e) {
      print(e);
      return Future.error('e');
    }
  }

  Future<bool> doIHaveEditProfileReq() async {
    try {
      final authResult = await FirebaseAuth.instance.currentUser();
      final snapShot =
          await db.collection('edit_req').document(authResult.uid).get();
      return snapShot.exists;
    } catch (e) {
      print(e);
      return Future.error('e');
    }
  }

  Future<CPEntity> getCpById({String id}) async{
    try {
      CPEntity cp;
       final snapShot =
          await db.collection('users').document(id).get();
      cp = CPEntity(
        buildingNO: snapShot.data['buildingNO'],
        city: snapShot.data['city'],
        nameOfCompany: snapShot.data['nameOfCompany'],
        nameOfOwner: snapShot.data['nameOfOwner'],
        phoneNo: snapShot.data['phoneNo'],
        status: snapShot.data['status'],
        street: snapShot.data['street'],
        zipCode: snapShot.data['zipCode'],
        uid: snapShot.data['uid'],
        email: snapShot.data['email'],
        district: snapShot.data['district'],
        long: snapShot.data['long'],
        lat: snapShot.data['lat'],
      );
      return cp;
    } catch (e) {
      print(e);
      return Future.error('e');
    }



  }
}
