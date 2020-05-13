import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:recycleme/repos/cpRepo.dart';
import 'package:recycleme/widgets/normal/edit_profile/EditProfileInputFeild.dart';
import 'package:recycleme/widgets/normal/shadow_button.dart';

class EditCpProfileScreen extends StatefulWidget {
  @override
  _EditCpProfileScreenState createState() => _EditCpProfileScreenState();
}

class _EditCpProfileScreenState extends State<EditCpProfileScreen> {
  CpRepo repo = CpRepo();
  TextEditingController _email = TextEditingController();
  TextEditingController _nameOfCompany = TextEditingController();
  TextEditingController _nameOfOwner = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _street = TextEditingController();
  TextEditingController _district = TextEditingController();
  TextEditingController _buildingNO = TextEditingController();
  TextEditingController _zipCode = TextEditingController();
  TextEditingController _phoneNo = TextEditingController();
  bool isLoading = true;
  bool doIHaveAEditReq = false;

  @override
  void initState() {
    _email.text = '';
    _nameOfCompany.text = '';
    _nameOfOwner.text = '';
    _city.text = '';
    _street.text = '';
    _district.text = '';
    _buildingNO.text = '';
    _zipCode.text = '';
    _phoneNo.text = '';
    repo.doIHaveEditProfileReq().then((val) {
      setState(() {
        doIHaveAEditReq = val;
      });
    });
    repo.getCurrentCpProfile().then((cp) {
      _email.text = cp.email;
      _nameOfCompany.text = cp.nameOfCompany;
      _nameOfOwner.text = cp.nameOfOwner;
      _city.text = cp.city;
      _street.text = cp.street;
      _district.text = cp.district;
      _buildingNO.text = cp.buildingNO;
      _zipCode.text = cp.zipCode;
      _phoneNo.text = cp.phoneNo;
      setState(() {
        isLoading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
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
                        'Edit Information',
                        style: TextStyle(
                            fontSize: 30,
                            color: const Color(0xff4D525D),
                            fontFamily: 'Lato Bold'),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: doIHaveAEditReq,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'You Have Edit Reqist in reviw ,',
                            style: TextStyle(
                                fontSize: 20,
                                color: const Color(0xff4D525D),
                                fontFamily: 'Lato Bold'),
                          ),
                          Text(
                            'You Can Wait Or Update Over it',
                            style: TextStyle(
                                fontSize: 20,
                                color: const Color(0xff4D525D),
                                fontFamily: 'Lato Bold'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Text(
                      'Edit your Company info',
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
                          controller: _nameOfCompany,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InputField(
                          hint: 'Owner Name',
                          padding: 0,
                          controller: _nameOfOwner,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InputField(
                          hint: 'Email',
                          padding: 0,
                          controller: _email,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InputField(
                          hint: 'City',
                          padding: 0,
                          controller: _city,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: InputField(
                                hint: 'District',
                                padding: 0,
                                controller: _district,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: InputField(
                                hint: 'Street',
                                padding: 0,
                                controller: _street,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: InputField(
                                hint: 'building number',
                                padding: 0,
                                controller: _buildingNO,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: InputField(
                                hint: 'zip code',
                                padding: 0,
                                controller: _zipCode,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InputField(
                          hint: 'phone number',
                          padding: 0,
                          controller: _phoneNo,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        ShadowButton(
                          onClick: () {
                            if (_email.text.trim().length == 0 ||
                                _nameOfCompany.text.trim().length == 0 ||
                                _nameOfOwner.text.trim().length == 0 ||
                                _city.text.trim().length == 0 ||
                                _district.text.trim().length == 0 ||
                                _street.text.trim().length == 0 ||
                                _buildingNO.text.trim().length == 0 ||
                                _zipCode.text.trim().length == 0 ||
                                _phoneNo.text.trim().length == 0) {
                              Fluttertoast.showToast(
                                  msg: 'don\'t leave any fields blank');
                              return;
                            }

                            repo.sendEditProfileReq({
                              'buildingNO': _buildingNO.text,
                              'city': _city.text,
                              'district': _district.text,
                              'email': _email.text,
                              'nameOfCompany': _nameOfCompany.text,
                              'nameOfOwner': _nameOfOwner.text,
                              'phoneNo': _phoneNo.text,
                              'street': _street.text,
                              'zipCode': _zipCode.text,
                              'date': DateTime.now()
                            });
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
      ),
    );
  }
}
