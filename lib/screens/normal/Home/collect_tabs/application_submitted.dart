import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ApplicationSubmitted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            FontAwesomeIcons.check,
            color: Color(0xFF31C801),
            size: 35,
          ),
          SizedBox(
            height: 35,
          ),
          Text(
            'Your application successfully \n submitted',
            style: TextStyle(
                color: Color(0xD9464646),
                fontSize: 20,
                fontFamily: 'Lato Bold'),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 35,
          ),
          InkWell(
              onTap: () {
                // TODO ON TAB
              },
              child: Text(
                'Check status',
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF528EFD),
                    fontFamily: 'Lato Bold'),
              )),
        ],
      ),
    );
  }
}
