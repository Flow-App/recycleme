import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CollectContainer extends StatefulWidget {
  final Widget child;
    String price;
    String weight;
  final Function onPress;
  final String text;

  CollectContainer(
      {this.child,
      this.onPress,
      double totalPrice,
      double totalWeight,
      this.text}) {
    price = totalPrice
            .toStringAsFixed(totalPrice.truncateToDouble() == totalPrice ? 0 : 2);
    weight = totalWeight
        .toStringAsFixed(totalWeight.truncateToDouble() == totalWeight ? 0 : 2);
  }

  @override
  _CollectContainerState createState() => _CollectContainerState();
}

class _CollectContainerState extends State<CollectContainer> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(8),
      child: Stack(
        children: <Widget>[
          Card(
              child: Column(
            children: <Widget>[
              Expanded(
                child: widget.child,
              ),
              SizedBox(
                height: 80,
              )
            ],
          )),
          Positioned(
            bottom: -6,
            child: Row(
              children: <Widget>[
                // weight button
                Container(
                  height: 66,
                  width: size.width * 0.30,
                  decoration: BoxDecoration(
                      color: Color(0xFF98DD9E),
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(19))),
                  child: Center(
                    child: Text(
                      '${widget.weight} ~g',
                      style: TextStyle(
                          fontFamily: 'Lato Regular',
                          color: Colors.white,
                          fontSize: 20),
                    ),
                  ),
                ),
                Container(
                  height: 66,
                  width: size.width * 0.30,
                  color: Color(0xFF98DD9E),
                  child: Center(
                    child: Text(
                      '${widget.price} ~UAH',
                      style: TextStyle(
                          fontFamily: 'Lato Regular',
                          color: Colors.white,
                          fontSize: 20),
                    ),
                  ),
                ),
                InkWell(
                  onTap: widget.onPress,
                  child: Container(
                    height: 80,
                    width: size.width * 0.36,
                    decoration: BoxDecoration(
                        color: Color(0xFF528EFD),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(19))),
                    child: Center(
                      child: Text(
                        widget.text,
                        style: TextStyle(
                            fontFamily: 'Lato Regular',
                            color: Colors.white,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class OnePixleLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        /* Container(
                width: 1,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        width: 1,
                         color: Color(0xFF98DD9E),
                        ),
                      ),

    Container(
    width: 1,
    color: Colors.white
    ),

    Expanded(
    child: Container(
    width: 1,
    color: Color(0xFF98DD9E),
    ),*/
        );
  }
}
