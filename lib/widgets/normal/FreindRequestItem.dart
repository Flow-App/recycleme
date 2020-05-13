import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycleme/entities/NotificationEntity.dart';
import 'package:recycleme/helpers/DateConverter.dart' as DateConvert;
class FriendRequestItem extends StatelessWidget {
  final NotificationEntity request;

  final Function onAddClicked;

  final Function onIgnoreClicked;

  FriendRequestItem({this.request, this.onIgnoreClicked, this.onAddClicked});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 13,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                request.profilePic,
                width: 75,
                height: 75,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${request.name} wants to add you',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Lato Bold',
                        color: Color(0xff4E525E)),
                  ),
                  Text(
                    DateConvert.getConvertToStringDate(date : request.date),
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Lato Regular',
                        color: Color(0xD94E525E)),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: IconButton(
                          onPressed: onIgnoreClicked,
                          icon: Row(
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.times,
                                color: Color(0xFFED4949),
                              ),
                              Text(
                                '  Ignore',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Lato Regular',
                                    color: Color(0xFF4E525E)),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: onAddClicked,
                          icon: Row(
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.plus,
                                color: Color(0xff7CDE86),
                              ),
                              Text(
                                '  Add',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Lato Regular',
                                    color: Color(0xFF4E525E)),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
