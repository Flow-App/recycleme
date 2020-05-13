import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recycleme/entities/CPEntity.dart';
import 'package:recycleme/entities/FileEntity.dart';

enum CpStatus { Approved, Pending, Rejected }

class AdminRepo {
  static Firestore _db = Firestore.instance;

  Future<List<CPEntity>> getCpByStatus({CpStatus status}) async {
    try {
      String suatusString;
      switch (status) {
        case CpStatus.Approved:
          suatusString = 'approved';
          break;
        case CpStatus.Pending:
          suatusString = 'await';
          break;
        case CpStatus.Rejected:
          suatusString = 'rejected';
          break;
      }
      final documents = await _db
          .collection('users')
          .where('role', isEqualTo: 'cp')
          .where('authStatus', isEqualTo: suatusString)
          .getDocuments();
      List<CPEntity> cps = [];
      documents.documents.forEach((doc) {
        cps.add(CPEntity(
            buildingNO: doc['buildingNO'],
            city: doc['city'],
            district: doc['district'],
            email: doc['email'],
            nameOfCompany: doc['nameOfCompany'],
            nameOfOwner: doc['nameOfOwner'],
            phoneNo: doc['phoneNo'],
            street: doc['street'],
            uid: doc['uid'],
            zipCode: doc['zipCode']));
      });
      return cps;
    } catch (e) {
      return Future.error(e);
    }
  }

//  Future<bool> changeCpStatus({String id, CpStatus status}) async {}

  Future<List<FileEntity>> getCpFiles({String uid}) async {
    try {
      final documents = await _db
          .collection('users')
          .document(uid)
          .collection('files')
          .getDocuments();
      List<FileEntity> files = [];
      documents.documents.forEach((doc) {
        files.add(FileEntity(
          url: doc['url'],
          fileName: doc['fileName'],
          date: doc['date'],
        ));
      });
      return files;
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
//  Future<List<FileEntity>> getCpFiles({String uid}) async {
//    try {
//      final documents = await _db
//          .collection('users')
//          .document(uid)
//          .collection('files')
//          .getDocuments();
//      List<FileEntity> files = [];
//      documents.documents.forEach((doc) {
//        files.add(FileEntity(
//          url: doc['url'],
//          fileName: doc['fileName'],
//          date: doc['date'],
//        ));
//      });
//      return files;
//    } catch (e) {
//      print(e);
//      return Future.error(e);
//    }
//  }
}
