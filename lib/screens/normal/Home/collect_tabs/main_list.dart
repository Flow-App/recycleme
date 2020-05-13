import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycleme/blocs/normal/collectTap/collect_bloc.dart';
import 'package:recycleme/entities/ListItemEntity.dart';
import 'package:recycleme/screens/normal/Home/collect_tabs/main_list_item.dart';

import 'collectContainer.dart';

class MainList extends StatefulWidget {
  @override
  _MainListState createState() => _MainListState();
}

class _MainListState extends State<MainList> {
  List<ListItemEntity> items = [];
  List<Widget> widgets = [];

  void buildItems() {
    List<ListItemEntity> plasticList = [];
    List<ListItemEntity> glassList = [];
    List<ListItemEntity> paperList = [];
    List<ListItemEntity> tinList = [];
    List<ListItemEntity> batteryList = [];
    widgets = [];
    items.forEach((item) {
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
          padding: EdgeInsets.only(left: 20 ,top: 15),
          child: Text(
            'Plastic',
            style: TextStyle(
                fontFamily: 'Lato Bold',
                fontSize: 16,
                color: Color(0xFF4E525E)),
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
          padding: EdgeInsets.only(left: 20 ,top: 15),

          child: Text(
            'Glass',
            style: TextStyle(
                fontFamily: 'Lato Bold',
                fontSize: 16,
                color: Color(0xFF4E525E)),
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
          padding: EdgeInsets.only(left: 20 ,top: 15),

          child: Text(
            'Tin',
            style: TextStyle(
                fontFamily: 'Lato Bold',
                fontSize: 16,
                color: Color(0xFF4E525E)),
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
          padding: EdgeInsets.only(left: 20 ,top: 15),
          child: Text(
            'Paper',
            style: TextStyle(
                fontFamily: 'Lato Bold',
                fontSize: 16,
                color: Color(0xFF4E525E)),
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
          padding: EdgeInsets.only(left: 20 ,top: 15),
          child: Text(
            'Battery',
            style: TextStyle(
                fontFamily: 'Lato Bold',
                fontSize: 16,
                color: Color(0xFF4E525E)),
          ),
        ),
      );
      batteryList.forEach((item) {
        widgets.add(MainListITem(item));
      });
    }
    widgets.add(
      Row(
        children: <Widget>[
          InkWell(
            onTap: (){
              BlocProvider
                  .of<CollectBloc>(context).add(GoToCategoreies());
            },
            child: Container(
              margin: EdgeInsets.only(left: 20 ,top: 30),
              child: Text(
                'Add More',
                style: TextStyle(
                    fontFamily: 'Lato Bold',
                    fontSize: 16,
                    color: Color(0xFF528EFD)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalWeight = 0;
    double totalPrice = 0;
    items = BlocProvider
        .of<CollectBloc>(context)
        .allSelectedItems;
    items.forEach((item) {
              //        q          *  garams     = total grams
      totalPrice += ((item.quntity * item.brand.weight ) * item.brand.price  );
      totalWeight += (item.quntity * item.brand.weight);
    });
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
//TODO :: WHERE TO gO BACK >>>? ?? ? ? ? ? ? ? ??
                      //                        BlocProvider.of<CollectBloc>(context)
//                            .add(BackToSelectedItemsScreen());
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
                      'List',
                      style: TextStyle(
                          fontFamily: 'Lato Bold',
                          fontSize: 30,
                          color: Color(0xFF4D525D)),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: CollectContainer(
                  child: ListView(
                    children: widgets,
                  ),
                  onPress: () {
                    BlocProvider.of<CollectBloc>(context)
                        .add(UserClickedFinish());
                  },
                  totalWeight: totalWeight,
                  totalPrice: totalPrice/1000,
                  text: 'Finish',
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
