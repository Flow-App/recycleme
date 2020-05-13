import 'package:flutter/material.dart';
import 'package:recycleme/entities/CPEntity.dart';
import 'package:recycleme/repos/AdminRepo.dart';

import 'cpFiles.dart';

class CpList extends StatefulWidget {
  @override
  _CpListState createState() => _CpListState();
}

class _CpListState extends State<CpList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('pending status')),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            FutureBuilder<List<CPEntity>>(
              future: AdminRepo().getCpByStatus(status: CpStatus.Pending),
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
                                  return CpFiles(
                                      name : snapShot.data[index].nameOfCompany ,
                                      uid: snapShot.data[index].uid)
                                  ;
                                }));
                              },
                              child: Column(
                                children: <Widget>[
                                  Text(snapShot.data[index].nameOfCompany),
                                  Text(snapShot.data[index].email),
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
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
