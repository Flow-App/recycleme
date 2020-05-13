import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycleme/blocs/normal/collectTap/collect_bloc.dart';
import 'package:recycleme/widgets/normal/SmaalStackedItem.dart';
import 'package:recycleme/widgets/normal/stackedItem.dart';
import 'package:recycleme/config.dart';

class WhatToCollectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Row(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    BlocProvider
                        .of<CollectBloc>(context).add(BackToMainCollectTab());                  },
                  child: Container(
                      width: 50,
                      height: 24,
                      child: Icon(
                        FontAwesomeIcons.chevronLeft,
                        color: Color(0xFF4E525E),

                      )),
                ),
                Text('What To Collect ?',
                    style: TextStyle(
                        color: Color(0xff4D525D),
                        fontSize: 26,
                        fontFamily: 'Lato Bold')),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.only(left: 25),

              child: Column(
                children: <Widget>[
                  PlasticStackedItem(
                    width: size.width * 0.90,
                    text: 'plastic',
                    onClick: () {
                      BlocProvider.of<CollectBloc>(context).add(UserSelectedCategory(Category.Plastic));
                    },
                    imageAssetPath: 'assets/bottles.png',
                  ),
                  Row(
                    children: <Widget>[
                      SmallStackedItem(
                        text: 'paper',
                        onClick: () {
                          BlocProvider.of<CollectBloc>(context).add(UserSelectedCategory(Category.Paper));
                        },
                        imageAssetPath: 'assets/packing.png',
                      ),
                      SmallStackedItem(
                        text: 'Glass',
                        onClick: () {
                          BlocProvider.of<CollectBloc>(context).add(UserSelectedCategory(Category.Glass));
                        },
                        imageAssetPath: 'assets/glass.png',
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SmallStackedItem(
                        text: 'Tin',
                        onClick: () {
                          BlocProvider.of<CollectBloc>(context).add(UserSelectedCategory(Category.Tin));

                        },
                        imageAssetPath: 'assets/beer-can.png',
                      ),
                      SmallStackedItem(
                        text: 'Battery',
                        onClick: () {
                          BlocProvider.of<CollectBloc>(context).add(UserSelectedCategory(Category.Battery));

                        },
                        imageAssetPath: 'assets/battery.png',
                      ),
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
