import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycleme/screens/Auth/password_normal.dart';
import 'package:recycleme/widgets/normal/InputFeild.dart';
import 'package:recycleme/widgets/normal/Image_picker.dart';
import 'package:recycleme/widgets/normal/age_picker.dart';
import 'package:recycleme/widgets/normal/district_picker.dart';
import 'package:recycleme/widgets/normal/gender_picker.dart';
import 'package:recycleme/widgets/normal/shadow_button.dart';

class SignUpNormaUserScreen extends StatefulWidget {
  @override
  _SignUpNormaUserScreenState createState() => _SignUpNormaUserScreenState();
}

class _SignUpNormaUserScreenState extends State<SignUpNormaUserScreen> {
  String _email = 'Email';
  String _name = 'Your Name';
  String _age = 'Age';
  String _gender = 'Gender';
  String _district = 'District';
  File _profilePic;

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
                    Expanded(
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
                  padding: EdgeInsets.only(left: 50),
                  child: Text(
                    'Add your info',
                    style: TextStyle(
                        fontSize: 20,
                        color: const Color(0xff4D525D),
                        fontFamily: 'Lato Bold'),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: ImagePickerWidget(
                          onImageChanged: (imageFile) {
                            _profilePic = imageFile;
                          },
                        ),
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
                      InputField(
                        hint: 'Your Name',
                        padding: 0,
                        onChanged: (val) {
                          _name = val;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          GenderPicker(
                            onGenderChanged: (val) {
                              _gender = val;
                            },
                          ),
                          SizedBox(width: 20),
                          AgePicker(
                            onAgeChanged: (val) {
                              _age = val;
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DistrictPicker(
                        onDistrictChanged: (val) {
                          _district = val;
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      ShadowButton(
                        onClick: () {
                          if (_email == 'Email' ||
                              _name == 'Your Name' ||
                              _age == 'Age' ||
                              _gender == 'Gender' ||
                              _district == 'District') {
                            Fluttertoast.showToast(
                                msg: 'don\'t leave any fields blank');
                            return;
                          }
                          if (_profilePic == null) {
                            Fluttertoast.showToast(
                                msg: 'pick your profile picture');
                            return;
                          }

                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return PickPasswordNormal(
                              age: _age,
                              district: _district,
                              email: _email,
                              gender: _gender,
                              name: _name,
                              profilePic: _profilePic,
                            );
                          }));
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
