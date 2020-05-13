import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycleme/repos/AuthRepo.dart';
import 'package:recycleme/screens/normal/settings/eidt_profile.dart';
import 'package:recycleme/screens/splash_screen.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        width: 50,
                        height: 24,
                        child: Icon(
                          FontAwesomeIcons.chevronLeft,
                          color: Color(0xFF4E525E),

                        )),
                  ),
                  Expanded(
                    child: Text(
                      'Settings',
                      style: TextStyle(
                          fontFamily: 'Lato Bold',
                          fontSize: 30,
                          color: Color(0xFF4D525D)),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SettingsItem(
                text: 'Edit profile',
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return EditProfileScreen();
                  }));
                },
              ),
              SettingsItem(
                text: 'Notifications',
                onPressed: () {},
              ),
              SettingsItem(
                text: 'Privacy',
                onPressed: () {},
              ),
              SettingsItem(
                text: 'General',
                onPressed: () {
          
                },
              ),
              SettingsItem(
                text: 'Security',
                onPressed: () async {
                  for(int i = 15 ; i< 30 ;i++){
                    await  Firestore.instance
                        .collection('users')
                        .document('9CkeWfNy33eqxc9Hd7KeCwFgVgK2')
                        .collection('friends').document(i.toString()).setData({
                      'uid': i.toString(), 'since': DateTime.now()

                    });
                    print('$i done');
                  }
                },
              ),
              SettingsItem(
                text: 'Help',
                onPressed: () {},
              ),
              SettingsItem(
                text: 'About',
                onPressed: () {},
              ),
              Expanded(
                child: SizedBox(),
              )
              ,
              SettingsItem(
                text: 'Log Out',
                onPressed: () async{
                  // TODO :: return user to home Screen

                  await AuthRepo().logOut();
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) {
                    return SplashScreen();
                  }));
                },
              ),
              SizedBox(height: 15,)
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final String text;
  final Function onPressed;

  SettingsItem({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(left: 50, top: 20),
        child: Container(
          width: double.infinity,
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Lato Regular',
              color: Color(0xD9464646),
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}
