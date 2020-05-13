import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycleme/blocs/normal/collectTap/collect_bloc.dart';
import 'package:recycleme/entities/CPEntity.dart';
import 'package:recycleme/entities/DealEntity.dart';
import 'package:recycleme/entities/ListItemEntity.dart';
import 'package:recycleme/repos/cpRepo.dart';
import 'package:recycleme/screens/normal/Home/collect_tabs/collectContainer.dart';
import 'package:recycleme/screens/normal/Home/collect_tabs/main_list_item.dart';

class FinshColletiong extends StatefulWidget {
  @override
  _DealDetailsScreenState createState() => _DealDetailsScreenState();
}

class _DealDetailsScreenState extends State<FinshColletiong> {
  String dealStatusText;
  Widget statusIcon;
  List<Widget> widgets = [];
  double weight = 0;
  double price = 0;
  List<ListItemEntity> items;

  void buildItems() {
    List<ListItemEntity> plasticList = [];
    List<ListItemEntity> glassList = [];
    List<ListItemEntity> paperList = [];
    List<ListItemEntity> tinList = [];
    List<ListItemEntity> batteryList = [];
     items.forEach((item) {
      price += item.brand.price;
      weight += item.brand.weight;
      switch (item.brand.category) {
        case 'plastic':
          plasticList.add(item);
          break;
        case 'tin':
          tinList.add(item);
          break;
        case 'paper':
          paperList.add(item);
          break;
        case 'battery':
          batteryList.add(item);
          break;
        case 'glass':
          glassList.add(item);
          break;
      }
    });

    if (plasticList.length > 0) {
      widgets.add(
        Container(
          padding: EdgeInsets.only(left: 20, top: 15),
          child: Text(
            'Plastic',
            style: TextStyle(
                fontFamily: 'Lato Bold',
                fontSize: 16,
                color: Color(0xCC4E525E)),
          ),
        ),
      );
      plasticList.forEach((item) {
        widgets.add(MainListITem(item));
      });
    }
    if (glassList.length > 0) {
      widgets.add(
        Container(
          padding: EdgeInsets.only(left: 20, top: 15),
          child: Text(
            'Glass',
            style: TextStyle(
                fontFamily: 'Lato Bold',
                fontSize: 16,
                color: Color(0xCC4E525E)),
          ),
        ),
      );
      glassList.forEach((item) {
        widgets.add(MainListITem(item));
      });
    }
    if (tinList.length > 0) {
      widgets.add(
        Container(
          padding: EdgeInsets.only(left: 20, top: 15),
          child: Text(
            'Tin',
            style: TextStyle(
                fontFamily: 'Lato Bold',
                fontSize: 16,
                color: Color(0xCC4E525E)),
          ),
        ),
      );
      tinList.forEach((item) {
        widgets.add(MainListITem(item));
      });
    }
    if (paperList.length > 0) {
      widgets.add(
        Container(
          padding: EdgeInsets.only(left: 20, top: 15),
          child: Text(
            'Paper',
            style: TextStyle(
                fontFamily: 'Lato Bold',
                fontSize: 16,
                color: Color(0xCC4E525E)),
          ),
        ),
      );
      paperList.forEach((item) {
        widgets.add(MainListITem(item));
      });
    }
    if (batteryList.length > 0) {
      widgets.add(
        Container(
          padding: EdgeInsets.only(left: 20, top: 15),
          child: Text(
            'Battery',
            style: TextStyle(
                fontFamily: 'Lato Bold',
                fontSize: 16,
                color: Color(0xCC4E525E)),
          ),
        ),
      );
      batteryList.forEach((item) {
        widgets.add(MainListITem(item));
      });
    }

    widgets.add(
      Container(
        padding: EdgeInsets.only(left: 20, top: 40, right: 10),
        child: Row(
          children: <Widget>[
            Text(
              'Weight:  ',
              style: TextStyle(
                  fontFamily: 'Lato Bold',
                  fontSize: 16,
                  color: Color(0xCC4E525E)),
            ),
            Text(
              (weight / 100).toString(),
              style: TextStyle(
                  fontFamily: 'Lato Bold',
                  fontSize: 24,
                  color: Color(0xFF8C81C8)),
            ),
            Expanded(
              child: SizedBox(),
            ),
            Text(
              'Price:  ',
              style: TextStyle(
                  fontFamily: 'Lato Bold',
                  fontSize: 16,
                  color: Color(0xCC4E525E)),
            ),
            Text(
              (price / 100).toString(),
              style: TextStyle(
                  fontFamily: 'Lato Bold',
                  fontSize: 24,
                  color: Color(0xFF528EFD)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    CPEntity cp = BlocProvider.of<CollectBloc>(context).selectedCp;
    items = BlocProvider.of<CollectBloc>(context).allSelectedItems;
    buildItems();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      BlocProvider.of<CollectBloc>(context)
                          .add(UserClickedFinish());
                    },
                    child: Container(
                        width: 50,
                        height: 24,
                        child: Icon(
                          FontAwesomeIcons.chevronLeft,
                          color: Color(0xFF4E525E),
                        )),
                  ),
                  Expanded(
                    child: Text(
                      'Deals',
                      style: TextStyle(
                          fontFamily: 'Lato Bold',
                          fontSize: 30,
                          color: Color(0xFF4D525D)),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    cp.nameOfCompany,
                    style: TextStyle(
                        fontFamily: 'Lato Bold',
                        fontSize: 24,
                        color: Color(0xFF4E525E)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  FutureBuilder<CPEntity>(
                      future: CpRepo().getCpById(id: cp.uid),
                      builder: (context, snapShot) {
                        if (snapShot.hasError) {
                          return Text('chechk you internt conncetion');
                        } else if (snapShot.hasData) {
                          return Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  '${snapShot.data.street} St. ${snapShot.data.district} ,  Ukraine , ${snapShot.data.zipCode} ',
                                  style: TextStyle(
                                    fontFamily: 'Lato Regular',
                                    fontSize: 18,
                                    color: Color(0xFF555555),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '+${snapShot.data.phoneNo}',
                                  style: TextStyle(
                                      fontFamily: 'Lato Regular',
                                      fontSize: 14,
                                      color: Color(0xFF3775E5)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'Woking hours:   ',
                                      style: TextStyle(
                                          fontFamily: 'Lato Regular',
                                          fontSize: 18,
                                          color: Color(0xFF555555)),
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width *
                                              0.57,
                                      child: Text(
                                        'snapShot.data.workingHours',
                                        style: TextStyle(
                                            fontFamily: 'Lato Regular',
                                            fontSize: 18,
                                            color: Color(0xFF161616)),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 5,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    //TODO SEND IMTiENT TO OPEN MAP
                                  },
                                  child: Text(
                                    'Show on map',
                                    style: TextStyle(
                                        fontFamily: 'Lato Bold',
                                        fontSize: 18,
                                        color: Color(0xFF6178B7)),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Container(
                            height: 200,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      }),
                  Text(
                    'List of recyclables',
                    style: TextStyle(
                        fontFamily: 'Lato Bold',
                        fontSize: 24,
                        color: Color(0xFF4E525E)),
                  ),

                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: CollectContainer(
                  child: ListView(
                    children: widgets,
                  ),
                  onPress: () {
                    BlocProvider.of<CollectBloc>(context)
                        .add(UserConfirmed());
                  },
                  totalWeight: weight,
                  totalPrice: price/1000,
                  text: 'Submit',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
