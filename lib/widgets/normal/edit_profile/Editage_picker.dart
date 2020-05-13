import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../shadow_conainer.dart';

// ignore: must_be_immutable
class AgePicker extends StatefulWidget {
  final Function onAgeChanged;
    String current ;

  AgePicker({this.onAgeChanged ,this.current});

  @override
  _AgePickerState createState() => _AgePickerState();
}

class _AgePickerState extends State<AgePicker> {
  String age;

  @override
  Widget build(BuildContext context) {
    age = widget.current;
    return Expanded(
      child: shadowContainer(
        child: Row(
          children: <Widget>[
            Expanded(
              child: DropdownButton<dynamic>(
                value: age,
                icon: SizedBox(),
                style: TextStyle(color: Colors.black, fontSize: 18.0),
                underline: SizedBox(),
                onChanged: (dynamic newValue) {
                  setState(() {
                    widget.current = newValue;
                    widget.onAgeChanged(newValue);

                  });
                },
                items: Ages.map<DropdownMenuItem<dynamic>>((dynamic value) {
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
      ),
    );
  }

  static const List<String> Ages = [
    'Age',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31',
    '32',
    '33',
    '34',
    '35',
    '36',
    '37',
    '38',
    '39',
    '40',
    '41',
    '42',
    '43',
    '44',
    '45',
    '46',
    '47',
    '48',
    '49',
    '50',
    '51',
    '52',
    '53',
    '54',
    '55',
    '56',
    '57',
    '58',
    '59',
    '60',
    '61',
    '62',
    '63',
    '64',
    '65',
    '66',
    '67',
    '68',
    '69',
    '70',
    '71',
    '72',
    '73',
    '74',
    '75',
    '76',
  ];
}
