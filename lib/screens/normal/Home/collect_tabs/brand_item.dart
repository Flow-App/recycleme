import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 import 'package:font_awesome_flutter/font_awesome_flutter.dart';
  import 'package:recycleme/entities/brand_entity.dart';

class BrandItem extends StatelessWidget {
  final BrandEntity item;
  final Function onClickAdd;
  BrandItem({this.item,this.onClickAdd});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.brandName,
                  style: TextStyle(
                      fontFamily: 'Lato Regular',
                      fontSize: 20,
                      color: Color(0xff464646)),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      '${item.weight} g',
                      style: TextStyle(color: Color(0xff9F9F9F)),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      '${item.price} ~UAH',
                      style: TextStyle(color: Color(0xff73BB58)),
                    )
                  ],
                )
              ],
            ),
          ),


          InkWell(
            onTap:  onClickAdd,
            child: Icon(
              FontAwesomeIcons.plus,
              size: 30,
              color: Color(0xFF252525),
            ),
          ),
          SizedBox(
            width: 10,
          ),

          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}

