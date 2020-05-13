import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:recycleme/entities/CPEntity.dart';

class PickCollectionPoint extends StatefulWidget {
  @override
  _PickCollectionPointState createState() => _PickCollectionPointState();
}

class _PickCollectionPointState extends State<PickCollectionPoint> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 25, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        // TODO _ back
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
                      'Collection Point',
                      style: TextStyle(
                          fontSize: 30,
                          color: const Color(0xff4D525D),
                          fontFamily: 'Lato Bold'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  padding: EdgeInsets.only(left: 30),
                  child: Column(
                    children: <Widget>[
                      CollectionPointItem(
                        index: 1,
                        cp: CPEntity(),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CollectionPointItem extends StatelessWidget {
  final int index;
  final CPEntity cp;

  CollectionPointItem({this.index, this.cp});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          index.toString(),
          style: TextStyle(
              color: Color(0xFF787878), fontSize: 14, fontFamily: 'Lato Bold'),
        ),
        SizedBox(width: 5),
        Expanded(
          child: Card(
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Column(
                  children: <Widget>[
                    Text(
                      'Collection point 1',
                      style: TextStyle(
                          color: Color(0xFF4E525E),
                          fontSize: 20,
                          fontFamily: 'Lato Bold'),
                    ),
                    Row(
                      children: <Widget>[

                      ],
                    )
                  ],
                )),
                Text(
                  '₴24',
                  style: TextStyle(fontSize: 30, color: Color(0xFF5A79B3)),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
