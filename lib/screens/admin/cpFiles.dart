import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recycleme/entities/FileEntity.dart';
import 'package:recycleme/repos/AdminRepo.dart';

import 'DisplayFile.dart';

class CpFiles extends StatelessWidget {
  final String uid;
  final String name;

  CpFiles({this.uid, this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(name),),
        body: Column(
          children: <Widget>[
            SizedBox(height: 10,),
            FutureBuilder<List<FileEntity>>(
              future: AdminRepo().getCpFiles(uid: uid),
              builder: (context, snapShot) {
                if (snapShot.hasData) {
                  if (snapShot.data.length > 0) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapShot.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return DisplayFile(
//                                          url : snapShot.data[index].url ,
                                      )
                                      ;
                                    }));
                              },
                              child: Column(
                                children: <Widget>[
                                  Text(snapShot.data[index].fileName),
                                  Text(DateFormat.yMMMd().format(snapShot.data[index].date.toDate())),

                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text('none'),
                    );
                  }
                } else if (snapShot.hasError) {
                  return Center(
                    child: Text('error'),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        )
    );
  }
}
