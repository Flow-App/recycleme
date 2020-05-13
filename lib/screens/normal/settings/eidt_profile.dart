


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:recycleme/entities/UserEntity.dart';
import 'package:recycleme/repos/normal_repo.dart';
import 'package:recycleme/widgets/normal/edit_profile/EditProfileInputFeild.dart';
import 'package:recycleme/widgets/normal/edit_profile/Editage_picker.dart';
import 'package:recycleme/widgets/normal/edit_profile/Editdistrict_picker.dart';
import 'package:recycleme/widgets/normal/edit_profile/Editgender_picker.dart';
import 'package:recycleme/widgets/normal/edit_profile/EdittProfile_Image_picker.dart';
import 'package:recycleme/widgets/normal/shadow_button.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _name = TextEditingController();
  String _age = 'Age';
  String _gender = 'Gender';
  String _district = 'District';
  String _userProfilePic ;
  File newProfilePic;
  bool isLoading = true ;
  @override
  void initState() {
    initData();
    super.initState();
  }
@override
  void dispose() {
    _email.dispose();
    _name.dispose();
     super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 60, left: 30, right: 30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Edit Profile',
                    style: TextStyle(
                        fontSize: 30,
                        color: const Color(0xff4D525D),
                        fontFamily: 'Lato Bold'),
                  ),
                  SizedBox(
                    height: 15,
                  ),
//                Text(
//                  'Add your info',
//                  style: TextStyle(
//                      fontSize: 20,
//                      color: const Color(0xff4D525D),
//                      fontFamily: 'Lato Bold'),
//                ),
                  Center(
                    child: ImagePickerWidget(
                      userPic: _userProfilePic,
                      onImageChanged: (imageFile) {
                        newProfilePic = imageFile;
                      },
                    ),
                  ),
                  InputField(
                    hint: 'Email',
                    controller: _email,
                    padding: 0,

                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InputField(
                    hint: 'Your Name',
                    padding: 0,
                   controller: _name,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      GenderPicker(
                        current: _gender,
                        onGenderChanged: (val) {
                          _gender = val;
                        },
                      ),
                      SizedBox(width: 20),
                      AgePicker(
                        current: _age,
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
                    current: _district,
                    onDistrictChanged: (val) {
                      _district = val;
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  ShadowButton(
                    onClick: () async {
                      if (_email.text == 'Email' ||
                          _name.text == 'Your Name' ||
                          _age == 'Age' ||
                          _gender == 'Gender' ||
                          _district == 'District') {
                        Fluttertoast.showToast(
                            msg: 'don\'t leave any fields blank');
                        return;
                      }
                      setState(() {
                        isLoading = true;
                      });
                 final bool isOk = await NormalRepo().updateCurrentUserProfile(
                      email: _email.text,
                      name: _name.text,
                      district: _district,
                      image: newProfilePic,
                      gender: _gender,
                      age: _age,
                      profilePic: _userProfilePic
                    );
                 if(isOk){
                   Fluttertoast.showToast(msg: 'Success');
                 }else{
                   Fluttertoast.showToast(msg: 'try again');
                 }
                 print(isOk);
                      setState(() {
                        isLoading = false;
                      });
                    },
                    text: 'Save Updates',
                    colorCode: 0xD9535C6E,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void initData() async {
    UserEntity user = await NormalRepo().getCurrentUserProfile();
    setState(() {
      _email.text = user.email;
      _name.text = user.name;
      _age = user.age;
      _gender = user.gender;
      _district = user.district;
      _userProfilePic = user.profilePic;
      isLoading = false;
    });
  }
}
