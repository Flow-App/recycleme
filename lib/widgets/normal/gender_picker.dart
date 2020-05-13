import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycleme/widgets/normal/shadow_conainer.dart';

class GenderPicker extends StatefulWidget {
  final Function onGenderChanged;

  GenderPicker({this.onGenderChanged});

  @override
  _GenderPickerState createState() => _GenderPickerState();
}

class _GenderPickerState extends State<GenderPicker> {
  final List<String> _genders = ['Gender', 'Male', 'Female'];

  String gender;

  @override
  void initState() {
    gender = _genders[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: shadowContainer(
        child: Row(
          children: <Widget>[
            Expanded(
              child: DropdownButton<dynamic>(
                value: gender,
               icon: SizedBox(),
                onChanged: (dynamic newValue) {
                  setState(() {
                    gender = newValue;
                    widget.onGenderChanged(gender);

                  });
                },
                underline: SizedBox(),
                items: _genders.map<DropdownMenuItem<dynamic>>((dynamic value) {
                  return DropdownMenuItem<dynamic>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(value,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Lato Bold',
                            color: Color(0x99535C6E),
                          )),
                    ),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                FontAwesomeIcons.angleDown,
                color: Color(0xFFA1BAFF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
