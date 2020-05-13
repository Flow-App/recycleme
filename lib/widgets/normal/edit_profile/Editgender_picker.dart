import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../shadow_conainer.dart';

// ignore: must_be_immutable
class GenderPicker extends StatefulWidget {
  final Function onGenderChanged;
    String current ;
  GenderPicker({this.onGenderChanged , this.current});

  @override
  _GenderPickerState createState() => _GenderPickerState();
}

class _GenderPickerState extends State<GenderPicker> {
  final List<String> _genders = ['Gender', 'Male', 'Female'];
  String gender;

  @override
  Widget build(BuildContext context) {
    gender = widget.current;

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
                    widget.current = newValue;
                    widget.onGenderChanged(newValue);

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
