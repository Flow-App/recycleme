import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:recycleme/entities/NotificationEntity.dart';
import 'package:recycleme/entities/UserEntity.dart';
import 'package:recycleme/entities/brand_entity.dart';

class NormalRepo {
  static final Firestore db = Firestore.instance;

  Future<List<UserEntity>> getUsersFriendsByRating() async {
    try {
      final currentUser = await getCurrentUserProfile();
      List<UserEntity> usersList = [currentUser];
      List<String> friendsIds = [];
      final friendsCollection = await db
          .collection('users')
          .document(currentUser.uid)
          .collection('friends')
          .getDocuments();
      friendsCollection.documents.forEach((friendDoc) {
        friendsIds.add(friendDoc['uid']);
      });
      for (int i = 0; i < friendsIds.length; i++) {
        final userDoc = await db.collection('users').document(friendsIds[i]).get();
        List<ItemTransAction> userTransActions = [];
        if (userDoc.data['ItemTransAction'] != null && userDoc.data['ItemTransAction'].length != null) {
          for (int i = 0; i < userDoc.data['ItemTransAction'].length; i++) {
            userTransActions.add(ItemTransAction(
              type: userDoc.data['ItemTransAction'][i]['type'],
              amount: double.parse(
                  userDoc.data['ItemTransAction'][i]['amount'].toString()),
              date: DateTime.fromMillisecondsSinceEpoch(userDoc
                  .data['ItemTransAction'][i]['date'].millisecondsSinceEpoch),
              price: double.parse(
                  userDoc.data['ItemTransAction'][i]['price'].toString()),
            ));
          }
        }
        usersList.add(UserEntity(
            uid: userDoc.data['uid'],
            email: userDoc.data['email'],
            age: userDoc.data['age'],
            name: userDoc.data['name'],
            gender: userDoc.data['gender'],
            district: userDoc.data['district'],
            profilePic: userDoc.data['profilePic'] == null ?currentUser.profilePic :userDoc.data['profilePic'],
            transActions: userTransActions));
      }

      return usersList;
    } catch (e) {
      print(e);
      return Future.error('e');
    }
  }

  Future<List<UserEntity>> getUsersByName({String name}) async {
    try {
      List<UserEntity> usersList = [];
      final snapShots = await db
          .collection('users')
          .where('name', isEqualTo: name)
          .getDocuments();
      snapShots.documents.forEach((user) {
        usersList.add(UserEntity(
          uid: user['uid'],
          email: user['email'],
          age: user['age'],
          name: user['name'],
          gender: user['gender'],
          district: user['district'],
          profilePic: user['profilePic'],
        ));
      });
      return usersList;
    } catch (e) {
      print(e);
      return Future.error('e');
    }
  }

  Future<UserEntity> getCurrentUserProfile() async {
    try {
      UserEntity user;
      final authResult = await FirebaseAuth.instance.currentUser();
      final snapShot =
          await db.collection('users').document(authResult.uid).get();
//          await db.collection('users').document('22').get();
      List<ItemTransAction> userTransActions = [];
      for (int i = 0; i < snapShot.data['ItemTransAction'].length; i++) {
        userTransActions.add(ItemTransAction(
          type: snapShot.data['ItemTransAction'][i]['type'],
          amount: double.parse(
              snapShot.data['ItemTransAction'][i]['amount'].toString()),
          date: DateTime.fromMillisecondsSinceEpoch(snapShot
              .data['ItemTransAction'][i]['date'].millisecondsSinceEpoch),
          price: double.parse(
              snapShot.data['ItemTransAction'][i]['price'].toString()),
        ));
      }
      user = UserEntity(
          uid: snapShot.data['uid'],
          email: snapShot.data['email'],
          age: snapShot.data['age'],
          name: snapShot.data['name'],
          gender: snapShot.data['gender'],
          district: snapShot.data['district'],
          profilePic: snapShot.data['profilePic'],
          transActions: userTransActions);
      return user;
    } catch (e) {
      print(e);
      return Future.error('e');
    }
  }

  Future<int> getCurrentUserNotificationsCount() async {
    try {
      final authResult = await FirebaseAuth.instance.currentUser();
      final snapShots = await db
          .collection('users')
          .document(authResult.uid)
          .collection('notifications')
          .getDocuments();
      return snapShots.documents.length;
    } catch (e) {
      print(e);
      return Future.error('e');
    }
  }

  Future<bool> updateCurrentUserProfile({
    String name,
    String gender,
    String email,
    String age,
    String district,
    String profilePic,
    File image,
  }) async {
    //  1. sign up
    //  2. upload a photo
    //  3. create an account
    try {
      var url;
      final authResult = await FirebaseAuth.instance.currentUser();
      if (image != null) {
        final FirebaseStorage _storage =
            FirebaseStorage(storageBucket: 'gs://recycleme-977e1.appspot.com');
        StorageUploadTask _uploadTask;
        String filePath = 'usersProfilePics/${authResult.uid}.png';
        _uploadTask = _storage.ref().child(filePath).putFile(image);
        var snapshot = await _uploadTask.onComplete;
        url = await snapshot.ref.getDownloadURL();
      } else {
        url = profilePic;
      }
      // if user sign Up Successfully
      await Firestore.instance
          .collection('users')
          .document(authResult.uid)
          .updateData({
        'name': name,
        'email': email,
        'age': age,
        'district': district,
        'profilePic': url,
        'gender': gender
      });
      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }

  Future<bool> sendFriendRequest({String id}) async {
    try {
      final userEnitiy = await getCurrentUserProfile();
      final Map<String, dynamic> request = {
        'uid': userEnitiy.uid,
        'name': userEnitiy.name,
        'profilePic': userEnitiy.profilePic,
        'date': DateTime.now(),
        'type': 'freind'
      };
      await db
          .collection('users')
          .document(id)
          .collection('notifications')
          .document(userEnitiy.uid)
          .setData(request);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> cancelFriendReq({String id}) async {
    try {
      final userEnitiy = await getCurrentUserProfile();
      await db
          .collection('users')
          .document(id)
          .collection('notifications')
          .document(userEnitiy.uid)
          .delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> doISendHimAFriendReqBefore({String id}) async {
    try {
      final userEnitiy = await getCurrentUserProfile();
      final doc = await db
          .collection('users')
          .document(id)
          .collection('notifications')
          .document(userEnitiy.uid)
          .get();

      return doc.exists;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> isHeMyFriend({String id}) async {
    try {
      final userEnitiy = await getCurrentUserProfile();
      final doc = await db
          .collection('users')
          .document(userEnitiy.uid)
          .collection('friends')
          .document(id)
          .get();

      return doc.exists;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> deleteHeMyFriend({String id}) async {
    try {
      final userEnitiy = await getCurrentUserProfile();
      await db
          .collection('users')
          .document(userEnitiy.uid)
          .collection('friends')
          .document(id)
          .delete();
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<NotificationEntity>> getUsersNotifications() async {
    try {
      final userEnitiy = await getCurrentUserProfile();
      final docs = await db
          .collection('users')
          .document(userEnitiy.uid)
          .collection('notifications')
          .getDocuments();
      List<NotificationEntity> list = [];
      docs.documents.forEach((doc) {
        list.add(NotificationEntity(
          name: doc['name'],
          uid: doc['uid'],
          type: doc['type'],
          profilePic: doc['profilePic'],
          date: DateTime.fromMillisecondsSinceEpoch(
              doc['date'].millisecondsSinceEpoch),
        ));
      });
      return list;
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  Future<void> ignoreFreindRequest({String id}) async {
    try {
      final userEnitiy = await getCurrentUserProfile();
      await db
          .collection('users')
          .document(userEnitiy.uid)
          .collection('notifications')
          .document(id)
          .delete();
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> acceptFriendRequest({String id}) async {
    try {
      await ignoreFreindRequest(id: id);
      final me = await getCurrentUserProfile();
      await db
          .collection('users')
          .document(me.uid)
          .collection('friends')
          .document(id)
          .setData({'uid': id, 'since': DateTime.now()});
      await db
          .collection('users')
          .document(id)
          .collection('friends')
          .document(me.uid)
          .setData({'uid': me.uid, 'since': DateTime.now()});
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> doIHavePendingLists() async {
    try {
      final userEnitiy = await getCurrentUserProfile();
      final doc =
          await db.collection('pending_lists').document(userEnitiy.uid).get();

      return doc.exists;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<BrandEntity>> getUsersFavBrands() async {
    try {
      final userEnitiy = await getCurrentUserProfile();
      final docs = await db
          .collection('users')
          .document(userEnitiy.uid)
          .collection('fav_brands')
          .getDocuments();
      List<BrandEntity> list = [];
      docs.documents.forEach((doc) {
        list.add(BrandEntity(
          price: doc.data['price'],
//          type:  doc.data['type'],
          brandName: doc.data['brandName'],
          weight: doc.data['weight'],
        ));
      });
      return list;
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
}
