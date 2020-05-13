import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycleme/widgets/normal/shadow_conainer.dart';

class CpStatusPicker extends StatefulWidget {
  final Function onGenderChanged;

  CpStatusPicker({this.onGenderChanged});

  @override
  _CpStatusPickerState createState() => _CpStatusPickerState();
}

class _CpStatusPickerState extends State<CpStatusPicker> {
  final List<String> _status = ['Awating', 'Accepted', 'Rejected'];

  String gender;

  @override
  void initState() {
    gender = _status[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return shadowContainer(
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
              items: _status.map<DropdownMenuItem<dynamic>>((dynamic value) {
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
    );
  }
}
