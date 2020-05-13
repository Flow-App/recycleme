import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DonationScreenItem extends StatelessWidget {
  String amount;
  final String type;

  DonationScreenItem({double amount, this.type}) {
    this.amount =
        amount.toStringAsFixed(amount.truncateToDouble() == amount ? 0 : 1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                amount,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Lato Regular',
                    color: Colors.white),
              ),
              Text(
                '  kg',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Lato Light',
                    color: Colors.white),
              )
            ],
          ),
          Text(
            type,
            style: TextStyle(
                fontSize: 20, fontFamily: 'Lato Light', color: Colors.white),
          )
        ],
      ),
    );
  }
}
