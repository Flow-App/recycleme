import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycleme/widgets/normal/shadow_conainer.dart';

class DistrictPicker extends StatefulWidget {
  final Function onDistrictChanged;

  DistrictPicker({this.onDistrictChanged});

  @override
  _DistrictPickerState createState() => _DistrictPickerState();
}

class _DistrictPickerState extends State<DistrictPicker> {
  String district;

  @override
  void initState() {
    district = districts[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return shadowContainer(
      child: Row(
        children: <Widget>[
          Expanded(
            child: DropdownButton<dynamic>(
              value: district,
              icon: SizedBox(),
              style: TextStyle(color: Colors.black, fontSize: 18.0),
              underline: SizedBox(),
              onChanged: (dynamic newValue) {
                setState(() {
                  district = newValue;
                  widget.onDistrictChanged(district);
                });
              },
              items: districts.map<DropdownMenuItem<dynamic>>((dynamic value) {
                return DropdownMenuItem<dynamic>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Lato Bold',
                        color: Color(0x99535C6E),
                      ),
                    ),
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

  static const List<String> districts = [
    'District',
    'darnytskyi',
    'desnianskyi',
    'dniprovskyi',
    'holosiivskyi',
    'obolobskyi',
    'pecherskyi',
    'podilskyi',
    'Shevchenkivskyi',
    'Solomianskyi',
    'sviatoshynskyi',
  ];
}
