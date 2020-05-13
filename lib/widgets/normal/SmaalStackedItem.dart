import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SmallStackedItem extends StatelessWidget {
  final Function onClick;
  final String imageAssetPath;
  final String text;

  SmallStackedItem({ this.onClick, this.imageAssetPath, this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onClick,
        child: Container(
          height: 130,
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: 30,
                  child: Container(
                    height: 100, width: 160, child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
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
                right: 20,
                top: 15,
                child: Image.asset(imageAssetPath,
                fit: BoxFit.fill,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
