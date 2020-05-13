import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TimeFramePicker extends StatefulWidget {
  final Function omFrameChanged;

  TimeFramePicker({this.omFrameChanged});

  @override
  _TimeFramePickerState createState() => _TimeFramePickerState();
}

class _TimeFramePickerState extends State<TimeFramePicker> {
  String frame;

  @override
  void initState() {
    frame = timeFrames[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        DropdownButton<dynamic>(
          value: frame,
          icon: SizedBox(),
          style: TextStyle(color: Colors.black, fontSize: 18.0),
          underline: SizedBox(),
          onChanged: (dynamic newValue) {
            setState(() {
              frame = newValue;
              widget.omFrameChanged(frame);
            });
          },
          items: timeFrames.map<DropdownMenuItem<dynamic>>((dynamic value) {
            return DropdownMenuItem<dynamic>(
              value: value,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Lato Bold',
                  color: Color(0xD91C1C1C),
                ),
              ),
            );
          }).toList(),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Icon(
            FontAwesomeIcons.angleDown,
            color: Color(0xD91C1C1C),
          ),
        ),
      ],
    );
  }

  static const List<String> timeFrames = [
    'This Week',
    'This Month',
    'This Year',
  ];
}
