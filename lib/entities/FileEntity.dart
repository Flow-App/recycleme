
import 'package:cloud_firestore/cloud_firestore.dart';

class FileEntity {
  final String url;
  final String fileName;
  final Timestamp date ;

  FileEntity({this.url ,this.date,this.fileName});
}
