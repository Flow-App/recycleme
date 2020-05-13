import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycleme/screens/Auth/password_cp.dart';
import 'package:recycleme/widgets/normal/InputFeild.dart';
import 'package:recycleme/widgets/normal/shadow_button.dart';

class SignUpCollectionPoint extends StatefulWidget {
  @override
  _SignUpCollectionPointState createState() => _SignUpCollectionPointState();
}

class _SignUpCollectionPointState extends State<SignUpCollectionPoint> {
  String _email = 'Email';
  String _nameOfCompany = 'Company Name';
  String _nameOfOwner = 'Owner Name';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 35, right: 30),
          child: SingleChildScrollView(
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
                    ),
                    Text(
                      'Sign Up',
                      style: TextStyle(
                          fontSize: 30,
                          color: const Color(0xff4D525D),
                          fontFamily: 'Lato Bold'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left :50),
                  child: Text(
                    'Add your Company info',
                    style: TextStyle(
                        fontSize: 20,
                        color: const Color(0xff4D525D),
                        fontFamily: 'Lato Bold'),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.only(left: 30),
                  child: Column(
                    children: <Widget>[
                      InputField(
                        hint: 'Company Name',
                        padding: 0,
                        onChanged: (val) {
                          _nameOfCompany = val;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InputField(
                        hint: 'Owner Name',
                        padding: 0,
                        onChanged: (val) {
                          _nameOfOwner = val;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InputField(
                        hint: 'Email',
                        padding: 0,
                        onChanged: (val) {
                          _email = val;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ShadowButton(
                        onClick: () {
                          if (_email == 'Email' ||
                              _nameOfCompany == 'Company Name' ||
                              _nameOfOwner == 'Owner Name') {
                            Fluttertoast.showToast(
                                msg: 'don\'t leave any fields blank');
                            return;
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) {
                                return PickPasswordCP(
                                  email: _email,
                                  nameOfCompany: _nameOfCompany,
                                  nameOfOwner: _nameOfOwner,
                                );
                              },
                            ),
                          );
                        },
                        text: 'Next',
                        colorCode: 0xD9535C6E,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
