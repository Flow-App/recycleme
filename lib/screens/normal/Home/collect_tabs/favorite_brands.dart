import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycleme/blocs/normal/collectTap/collect_bloc.dart';
import 'package:recycleme/entities/TypeEntity.dart';
import 'package:recycleme/entities/brand_entity.dart';
import 'package:recycleme/repos/collect_repo.dart';
import 'package:recycleme/screens/normal/Home/collect_tabs/brand_item.dart';
import 'package:recycleme/config.dart';

class FavoriteBrands extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Category selectedCategory =
        BlocProvider.of<CollectBloc>(context).selectedCategoery;
    String title;
    switch (selectedCategory) {
      case Category.Plastic:
        title = 'Plastic';
        break;
      case Category.Glass:
        title = 'Glass';
        break;
      case Category.Tin:
        title = 'Tin';
        break;
      case Category.Battery:
        title = 'Battery';
        break;
      case Category.Paper:
        title = 'Paper';
        break;
    }

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
                    BlocProvider.of<CollectBloc>(context)
                        .add(BackToAddToList());
                  },
                  child: Container(
                      width: 50,
                      height: 24,
                      child: Icon(
                        FontAwesomeIcons.chevronLeft,
                        color: Color(0xFF4E525E),
                      )),
                ),
                Text(title + ' Brands',
                    style: TextStyle(
                        color: Color(0xff4D525D),
                        fontSize: 26,
                        fontFamily: 'Lato Bold')),
              ],
            ),
            Expanded(
              child: Container(
                  child: FutureBuilder<List<BrandEntity>>(
                future: CollectRepo().getUsersFavBrands(selectedCategory),
                builder: (context, snapShot) {
                  if (snapShot.hasData) {
                    if(snapShot.data.length > 0){
                      return ListView.builder(
                          itemCount: snapShot.data.length,
                          itemBuilder: (context, index) {
                            return BrandItem(item:snapShot.data[index],onClickAdd: (){
                              BlocProvider.of<CollectBloc>(context)
                                  .add(UserPickedABrand( snapShot.data[index]));
                            },);
                          });
                    }else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          Icon(
                            FontAwesomeIcons.list,
                            size: 90,
                          ),
                          Text(
                            'You Have No Favorite Brands Yet',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ],
                      );
                    }
                  }else if (snapShot.hasError){
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        Icon(
                          FontAwesomeIcons.list,
                          size: 90,
                        ),
                        Text(
                          'No itnrert connection',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ],
                    );
                  } else {
                    return  Center(child: CircularProgressIndicator());
                  }
                },
              )),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class TypeItem extends StatelessWidget {
  final TypeEntity typeEntity;
  Widget image;
  Widget icon;
  double width;
  Function onClick;

  TypeItem({this.typeEntity, this.onClick, this.width}) {
    if (typeEntity.picPath == '') {
      image = SizedBox();
    } else {
      image = Image.asset(
        typeEntity.picPath,
        fit: BoxFit.fill,
      );
    }

    if (typeEntity.iconPath == '') {
      icon = SizedBox();
    } else {
      icon = Image.asset(
        typeEntity.iconPath,
//        fit: BoxFit.fitWidth,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick(this.typeEntity);
      },
      child: Container(
          height: 140,
          child: Stack(children: <Widget>[
            Positioned(
                top: 30,
                child: Container(
                  height: 110,
                  width: width,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 10,
                  ),
                )),
            Positioned(width: 50, height: 50, top: 55, left: 10, child: icon),
            Positioned(right: 10, top: 10, child: image),
            Positioned(
              left: 70,
              top: 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    typeEntity.name,
                    style: TextStyle(
                        color: Color(0xFF232323),
                        fontFamily: 'Lato Bold',
                        fontSize: 18),
                  ),
                  Container(
                    width: 200,
                    child: Text(
                      typeEntity.samples,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          color: Color(0xFF232323),
                          fontFamily: 'Lato Regular',
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
            )
          ])),
    );
  }
}
