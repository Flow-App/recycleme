import 'package:flutter/material.dart';
import 'package:recycleme/entities/UserEntity.dart';
import 'package:recycleme/repos/AuthRepo.dart';
import 'package:recycleme/repos/normal_repo.dart';
import 'package:recycleme/screens/normal/Home/HomeScreen.dart';
import 'package:recycleme/widgets/normal/InputFeild.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:recycleme/widgets/normal/shadow_button.dart';

import 'pick_user_type.dart';

class LoginScreen extends StatefulWidget {
  static const InputDecoration inputDeco = const InputDecoration();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email;
  String _password;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 300,
                    child: Center(
                      child: Text(
                        'RecycleMe',
                        style: TextStyle(
                            color: Color(0x805BADF0),
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  InputField(
                    hint: 'Email',
                    padding: 20,
                    onChanged: (val) {
                      _email = val;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InputField(
                    hidden: true,
                    hint: 'Password',
                    padding: 20,
                    onChanged: (val) {
                      _password = val;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: ShadowButton(
                      colorCode: 0xFF535C6E,
                      text: 'Log in',
                      onClick: () async {
                        if (_email == null) {
                          Fluttertoast.showToast(msg: 'Email Cant be empty');
                          return;
                        }
                        if (_password == null) {
                          Fluttertoast.showToast(msg: 'password Cant be empty');
                          return;
                        }
                        setState(() {
                          _isLoading = true;
                        });
                        final status = await AuthRepo()
                            .signInWithEmailAndPassword(
                                email: _email, password: _password);
                        switch (status) {
                          case AuthStatus.LogInSuccessfully:
                            UserEntity user = await NormalRepo().getCurrentUserProfile();
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return HomeScreen(user);
                            }));
                            break;
                          case AuthStatus.WrongEmailOrPassword:
                            setState(() {
                              _isLoading = false;
                            });
                            Fluttertoast.showToast(
                                msg: 'Wrong Email Or Password !',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            break;
                          case AuthStatus.InvalidEmailOrPassWord:
                            setState(() {
                              _isLoading = false;
                            });
                            Fluttertoast.showToast(
                                msg: 'Invalid Email Or PassWord !',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black26,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            break;
                          default:
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'I don’t have an account  ',
                        style: TextStyle(
                            color: const Color(0x99535C6E),
                            fontFamily: 'Lato Regular',
                            fontSize: 18),
                      ),
                      InkWell(
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                              fontFamily: 'Lato Regular',
                              color: const Color(0xFF5581D7),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) {
                            return PickUserTypeScreen();
                          }));
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
