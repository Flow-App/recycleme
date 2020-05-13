import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:recycleme/entities/ListItemEntity.dart';

// ignore: must_be_immutable
class MainListITem extends StatelessWidget {
  final ListItemEntity item;
  double totalPrice;

  String price;

  MainListITem(this.item) {
    totalPrice = item.quntity * item.brand.price;
    price = totalPrice.toStringAsFixed(
        totalPrice.truncateToDouble() ==
                totalPrice
            ? 0
            : 2);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              item.brand.brandName,
              style: TextStyle(
                  fontFamily: 'Lato Regular',
                  fontSize: 16,
                  color: Color(0xCC4E525E)),
            ),
          ),
          Text(
            '${item.quntity}x',
            style: TextStyle(
                fontFamily: 'Lato Regular',
                fontSize: 16,
                color: Color(0xD94E525E)),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            ' UAH $price',
            style: TextStyle(
                fontFamily: 'Lato Bold',
                fontSize: 16,
                color: Color(0xD94E525E)),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
