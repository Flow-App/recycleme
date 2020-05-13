import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recycleme/widgets/normal/shadow_button.dart';

import 'cpList.dart';

class AdminHomeScreen extends StatefulWidget {
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Panale')),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ShadowButton(
              colorCode: 0xD9464646,
              onClick: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CpList();
                }));



              },
              text: 'manage cp',
            ),
            ShadowButton(
              colorCode: 0xD9464646,
              onClick: () {},
              text: 'manage users',
            ),
            ShadowButton(
              colorCode: 0xD9464646,
              onClick: () {},
              text: 'Add Items',
            )
            ,ShadowButton(
              colorCode: 0xD9464646,
              onClick: () {},
              text: 'manage Items',
            ),
            ShadowButton(
              colorCode: 0xD9464646,
              onClick: () {},
              text: 'add news',
            ),
            ShadowButton(
              colorCode: 0xD9464646,
              onClick: () {},
              text: 'manage news',
            )
          ],
        ),
      ),
    );
  }
}
