import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart' as p;

enum AuthStatus {
  WrongEmailOrPassword,
  LogInSuccessfully,
  InvalidEmailOrPassWord,
  SignUpFail,
  SignUpSuccessfully,
  LogOutSuccessfully,
  LogOutFailed,
  gotApproval,
  awaitingApproval,
  ApproveRejected
}

enum AuthRoles {
  Admin,
  User,
  Cp,
}

class AuthRepo {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static Firestore _db = Firestore.instance;

  Future<AuthRoles> getCurrentUserRole() async {
    try {
      final user = await _auth.currentUser();
      final doc = await _db.collection('users').document(user.uid).get();
      switch (doc.data['role']) {
        case 'user':
          return AuthRoles.User;
        case 'admin':
          return AuthRoles.Admin;
        case 'cp':
          return AuthRoles.Cp;
        default:
          return Future.error('err');
      }
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  Future<bool> isLoggedIn() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    final user = await _auth.currentUser();
    if (user == null || user.uid == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> isCp() async {
    final user = await _auth.currentUser();
    final snapShot = await _db.collection('users').document(user.uid).get();
    final String role = snapShot.data['role'];
    if (role == 'user') {
      return false;
    }
    return true;
  }

  Future<AuthStatus> logOut() async {
    try {
      await _auth.signOut();
      return AuthStatus.LogOutSuccessfully;
    } catch (e) {
      return AuthStatus.LogOutFailed;
    }
  }

  Future<AuthStatus> signInWithEmailAndPassword(
      {@required String email, @required String password}) async {
    try {
      final authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (authResult != null && authResult.user.uid != null) {
        return AuthStatus.LogInSuccessfully;
      } else {
        return AuthStatus.WrongEmailOrPassword;
      }
    } catch (e) {
      return AuthStatus.WrongEmailOrPassword;
    }
  }

  Future<AuthStatus> signUpNormalUser(
      {String name,
      String gender,
      String email,
      String age,
      String district,
      File image,
      String password}) async {
    print(image.path);
    //  1. sign up
    //  2. upload a photo
    //  3. create an account
    try {
      final authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (authResult == null || authResult.user.uid == null) {
        return AuthStatus.SignUpFail;
      }
      // if user sign Up Successfully
      final FirebaseStorage _storage =
          FirebaseStorage(storageBucket: 'gs://recycleme-977e1.appspot.com');
      StorageUploadTask _uploadTask;
      String filePath = 'usersProfilePics/${authResult.user.uid}.png';
      _uploadTask = _storage.ref().child(filePath).putFile(image);
      var snapshot = await _uploadTask.onComplete;
      var url = await snapshot.ref.getDownloadURL();
      await _db.collection('users').document(authResult.user.uid).setData({
        'role': 'user',
        'soldKg': 0,
        'uid': authResult.user.uid,
        'name': name,
        'email': email,
        'age': age,
        'district': district,
        'profilePic': url,
        'gender': gender
      });
      return AuthStatus.SignUpSuccessfully;
    } catch (err) {
      print(err);
      return AuthStatus.SignUpFail;
    }
  }

  Future<AuthStatus> signUpCP({
    String email,
    String nameOfCompany,
    String nameOfOwner,
    String password,
  }) async {
    //  1. sign up
    //  2. create an account
    try {
      final authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (authResult == null || authResult.user.uid == null) {
        return AuthStatus.SignUpFail;
      }
      // if user sign Up Successfully
      await _db.collection('users').document(authResult.user.uid).setData({
        'role': 'cp',
        'authStatus': 'await',
        'uid': authResult.user.uid,
        'email': email,
        'nameOfOwner': nameOfOwner,
        'nameOfCompany': nameOfCompany,
//        'city': city,
//        'district': district,
//        'street': street,
//        'buildingNO': buildingNO,
//        'zipCode': zipCode,
//        'phoneNo': phoneNo,
        // TODO Fix Types
//        'prices': {
//          'PP': i + 1,
//          'PS': i + 2,
//          'PVC': i + 3,
//          'HDPE': i + 4,
//          'paper': i + 5,
//          'glass': i + 6,
//          'steel': i + 7,
//          'aluminum': i + 8,
//          'battery1': i + 9,
//          'battery2': i + 10,
//        }
      });
      return AuthStatus.SignUpSuccessfully;
    } catch (err) {
      print(err);
      return AuthStatus.SignUpFail;
    }
  }

  Future<AuthStatus> isApproved() async {
    final user = await _auth.currentUser();
    final userDoc = await _db.collection('users').document(user.uid).get();
    final String status = userDoc.data['authStatus'];
    if (status == 'approved') {
      return AuthStatus.gotApproval;
    } else if (status == 'await') {
      return AuthStatus.awaitingApproval;
    } else if (status == 'rejected') {
      return AuthStatus.ApproveRejected;
    } else {
      return AuthStatus.ApproveRejected;
    }
  }

  Future<bool> uploadFiles({List<File> documents}) async {
    try {
      final user = await _auth.currentUser();
      for (var doc in documents) {
        final FirebaseStorage _storage =
            FirebaseStorage(storageBucket: 'gs://recycleme-977e1.appspot.com');
        StorageUploadTask _uploadTask;
        String filePath = 'regDocs/${user.uid}/${p.basename(doc.path)}';
        _uploadTask = _storage.ref().child(filePath).putFile(doc);
        var snapshot = await _uploadTask.onComplete;
        var url = await snapshot.ref.getDownloadURL();
        await _db
            .collection('users')
            .document(user.uid)
            .collection('files')
            .add({
          'url': url,
          'date': DateTime.now(),
          'fileName': p.basename(doc.path)
        });
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<int> howMuchCanIUpload() async {
    try {
      final user = await _auth.currentUser();
      final ref =
          _db.collection('users').document(user.uid).collection('files');
      final documents = await ref.getDocuments();
      final count = documents.documents.length;
      return 10 - count;
    } catch (e) {
      return Future.error('error');
    }
  }
}
