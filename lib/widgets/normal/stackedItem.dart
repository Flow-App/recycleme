import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlasticStackedItem extends StatelessWidget {
  final double width;
  final Function onClick;
  final String imageAssetPath;
  final String text;

  PlasticStackedItem({this.width, this.onClick, this.imageAssetPath, this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        height: 150,
        child: Stack(
          children: <Widget>[
            Positioned(
                top: 40,
                child: Container(
                  height: 100, width: width, child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment:  MainAxisAlignment.center,
                    children: <Widget>[
                      Text('   $text',style: TextStyle(
                        color: Color(0xFF232323),
                        fontFamily: 'Lato Regular',
                        fontSize: 20
                      ),
                      ),
                    ],
                  ),
                ),
                )),
            Positioned(
              right: 50,
              child: Image.asset(imageAssetPath,
              fit: BoxFit.fill,),
            )
          ],
        ),
      ),
    );
  }
}
