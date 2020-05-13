import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MiddleContainer extends StatelessWidget {
   String totalWeight;
   String totalPrice;

  MiddleContainer({double totalWeight, double totalPrice}){
    this.totalWeight =
        totalWeight.toStringAsFixed(totalWeight.truncateToDouble() == totalWeight ? 0 : 1);
    this.totalPrice =
        totalPrice.toStringAsFixed(totalPrice.truncateToDouble() == totalPrice ? 0 : 1);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  totalWeight,
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
              '________________',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Lato Regular',
                  color: Colors.white),
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  totalPrice,
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Lato Regular',
                      color: Colors.white),
                ),
                Text(
                  '  UAH',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Lato Light',
                      color: Colors.white),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
