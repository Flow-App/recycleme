import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recycleme/widgets/normal/MiddleContainer.dart';
import 'package:recycleme/widgets/normal/donationITem.dart';

class TopBoard extends StatelessWidget {
  final double plastic;
  final double glass;
  final double paper;
  final double battery;
  final double tin;
  final double price;
  final double total;

  TopBoard({this.plastic, this.glass, this.paper, this.battery, this.tin,this.total,this.price});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 30 ,left: 10,right: 10,bottom: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      DonationScreenItem(
                        amount: plastic,
                        type: 'Plastic',
                       ),
                      DonationScreenItem(
                        amount: tin,
                        type: 'Tin',
                      )
                    ],
                  ),
                  MiddleContainer(
                    totalWeight: total,
                    totalPrice: price,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: <Widget>[
                      DonationScreenItem(
                        amount: glass,
                        type: 'Glass',
                      ),
                      DonationScreenItem(
                        amount: paper,
                        type: 'Paper',
                      )
                    ],
                  )
                ],
              ),
            ),
            DonationScreenItem(
              amount: battery,
              type: 'Battery',
            )
          ],
        ),
      ),
    );
  }


}
