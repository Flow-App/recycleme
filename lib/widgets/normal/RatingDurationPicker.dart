import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RatingDurationPicker extends StatefulWidget {
  final Function onDurationChanged;

  RatingDurationPicker({this.onDurationChanged});

  @override
  _RatingDurationPickerState createState() => _RatingDurationPickerState();
}

class _RatingDurationPickerState extends State<RatingDurationPicker> {
  String duration;

  @override
  void initState() {
    duration = durations[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        DropdownButton<dynamic>(
          value: duration,
          icon: SizedBox(),
          style: TextStyle(color: Colors.black, fontSize: 18.0),
          underline: SizedBox(),
          onChanged: (dynamic newValue) {
            setState(() {
              duration = newValue;
              widget.onDurationChanged(duration);
            });
          },
          items: durations.map<DropdownMenuItem<dynamic>>((dynamic value) {
            return DropdownMenuItem<dynamic>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Lato Bold',
                    color: Color(0xFF989898),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Icon(
            FontAwesomeIcons.angleDown,
            color: Color(0xFFFA9B77),
          ),
        ),

      ],
    );
  }

  static const List<String> durations = [
    'Week',
    'Month',
    'Year',
    'All of Time'
  ];
}
