import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycleme/screens/Auth/sign_up_cp.dart';
import 'package:recycleme/screens/Auth/sign_up_normal.dart';
import 'package:recycleme/widgets/normal/shadow_button.dart';

class PickUserTypeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                  ),Expanded(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          fontSize: 30,
                          color: const Color(0xff4D525D),
                          fontFamily: 'Lato Bold'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Text(
                  'i want to',
                  style: TextStyle(
                      fontSize: 20,
                      color: const Color(0xff4D525D),
                      fontFamily: 'Lato Bold'),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 30,right: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ShadowButton(
                        text: 'sell my recyclables',
                        onClick: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return SignUpNormaUserScreen();
                          }));
                        },
                      ),
                      SizedBox(height: 40,),
                      ShadowButton(
                        text: 'buy recyclables materials',
                        onClick: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return SignUpCollectionPoint();
                          }));
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
