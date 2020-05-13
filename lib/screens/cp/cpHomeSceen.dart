import 'package:flutter/material.dart';
import 'package:recycleme/repos/AuthRepo.dart';
import 'package:recycleme/screens/Auth/login_screen.dart';

import 'EditCpProfileScreen.dart';

class CpHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text('editMyProfile'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return EditCpProfileScreen();
                  }));
                },
              ),
              RaisedButton(
                child: Text('logout'),
                onPressed: () async {
                  await AuthRepo().logOut();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  }));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
