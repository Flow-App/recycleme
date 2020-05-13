import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:recycleme/repos/AuthRepo.dart';
import 'package:recycleme/widgets/normal/InputFeild.dart';
import 'package:recycleme/widgets/normal/shadow_button.dart';


class PickPasswordNormal extends StatefulWidget {
  final String email;
  final String name;
  final String age;
  final String gender;
  final String district;
  final File profilePic;

  PickPasswordNormal(
      {this.email,
      this.name,
      this.age,
      this.gender,
      this.district,
      this.profilePic});

  @override
  _PickPasswordNormalState createState() => _PickPasswordNormalState();
}

class _PickPasswordNormalState extends State<PickPasswordNormal> {
  String _password;
  String _rePassword;
  bool isLoading = false;
  bool agreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 35, right: 30),
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
                  padding: const EdgeInsets.only(left: 50),
                  child: Text(
                    'Enter you password',
                    style: TextStyle(
                        fontSize: 20,
                        color: const Color(0xff4D525D),
                        fontFamily: 'Lato Bold'),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 30),
                    child: Column(
                      children: <Widget>[
                        InputField(
                          hidden: true,
                          hint: 'Your password',
                          padding: 0,
                          onChanged: (val) {
                            _password = val;
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        InputField(
                          hidden: true,
                          hint: 'Re-enter password',
                          padding: 0,
                          onChanged: (val) {
                            _rePassword = val;
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                //                      TODO :  Underline text && link to rules page

                                'I agree with the Terms and conditions of use ',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: const Color(0xff4D525D),
                                    fontFamily: 'Lato Bold'),
                              ),
                            ),
                            Checkbox(
                              value: agreed,
                              onChanged: (val) {
                                setState(() {
                                  agreed = val;
                                });
                              },
                            )
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        ShadowButton(
                          onClick: () async {
                            if (agreed) {
                              if (_password != _rePassword) {
                                Fluttertoast.showToast(msg: 'password did\'t match ');
                                return;
                              }

                              setState(() {
                                isLoading = true;
                              });
                              switch (await AuthRepo().signUpNormalUser(
                                  name: widget.name,
                                  password: _password,
                                  age: widget.age,
                                  email: widget.email,
                                  district: widget.district,
                                  gender: widget.gender,
                                  image: widget.profilePic)) {
                                case AuthStatus.SignUpFail:
                                  setState(() {
                                    isLoading = false;
                                    Fluttertoast.showToast(
                                        msg: 'check Your Internet connection ');
                                  });
                                  break;
                                case AuthStatus.SignUpSuccessfully:
                                  setState(() {
                                    isLoading = false;
//                            Navigator.pushReplacement(context,
//                                MaterialPageRoute(builder: (context) {
//                              return HomeScreen();
//                            }));
                                  });
                                  break;
                                default:
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg:
                                  'you must agree to the Terms and conditions of use');
                            }
                          },
                          text: 'Finish',
                          colorCode: 0xD9535C6E,
                        )
                      ],
                    ),
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
