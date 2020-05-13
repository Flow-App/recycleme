import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycleme/blocs/normal/collectTap/collect_bloc.dart';
import 'package:recycleme/entities/ListItemEntity.dart';
import 'package:recycleme/entities/brand_entity.dart';
import 'package:recycleme/screens/normal/Home/collect_tabs/brand_item.dart';
import 'package:recycleme/widgets/normal/SearchInputFeild.dart';
import 'package:recycleme/config.dart';

import 'collectContainer.dart';
import 'list_item_widget.dart';

class AddToList extends StatefulWidget {
  @override
  _AddToListState createState() => _AddToListState();
}

class _AddToListState extends State<AddToList> {
  Category selectedCategory;
  String title;
  String searchText;
  List<ListItemEntity> items = [];
  List<BrandEntity> searchBrands = [];
  TextEditingController searchController = TextEditingController();
  Future getter;

  @override
  Widget build(BuildContext context) {
    double totalWeight = 0;
    double totalPrice = 0;
    items = BlocProvider.of<CollectBloc>(context).itemsToAdd;
    items.forEach((item) {
      totalPrice += ((item.quntity * item.brand.weight) * item.brand.price);
      totalWeight += (item.quntity * item.brand.weight);
    });
    selectedCategory = BlocProvider.of<CollectBloc>(context).selectedCategoery;
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
      default:
    }
    items = BlocProvider.of<CollectBloc>(context).itemsToAdd;
    return BlocListener<CollectBloc, CollectState>(
      listener: (_, state) {
        if (state is AddListChanged) {
          setState(() {
//            items = state.list;
          });
        } else if (state is BrandsListChanged) {
          setState(() {
            searchBrands = state.list;
          });
        }
      },
      child: Scaffold(
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
                            .add(BackToSelectedItemsScreen());
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
                        title,
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
                SearchInputField(
                  controller: searchController,
                  padding: 15,
                  onChanged: (val) {
                    searchText = val;
                    if (val != null && val != '') {
                      getter = Future.delayed(Duration(seconds: 2), () {
                        BlocProvider.of<CollectBloc>(context)
                            .add(GetBrandByName(name: searchText));
                      });
                    } else {
                      setState(() {
                        searchBrands = [];
                        searchController.text = '';
                      });
                    }
                  },
                  hint: 'Search for brand',
                  onComplete: () {
                    BlocProvider.of<CollectBloc>(context)
                        .add(GetBrandByName(name: searchText));
                  },
                ),
                SizedBox(height: 15),
                Visibility(
                  visible: searchBrands.length > 0,
                  child: Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: searchBrands.length,
                        itemBuilder: (context, index) {
                          return BrandItem(
                              item: searchBrands[index],
                              onClickAdd: () {
                                BlocProvider.of<CollectBloc>(context)
                                    .add(UserPickedABrand(searchBrands[index]));
                                searchController.text = '';
                              });
                        }),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(width: 20),
                    MainCard(
                      onTap: () {
                        BlocProvider.of<CollectBloc>(context).add(AddByType());
                      },
                      iconData: FontAwesomeIcons.weightHanging,
                      title: 'Select Weight',
                    ),
                    SizedBox(width: 20),
                    MainCard(
                      onTap: () {
                        BlocProvider.of<CollectBloc>(context).add(AddByFav());
                      },
                      iconData: FontAwesomeIcons.solidHeart,
                      title: 'Favorites',
                    ),
                    SizedBox(width: 20),
                  ],
                ),

                Expanded(
                  child: CollectContainer(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return ListItemWidget(items[index]);
                        }),
                    onPress: () {
                      if (BlocProvider.of<CollectBloc>(context)
                              .itemsToAdd
                              .length ==
                          0) {
                        return;
                      }
                      BlocProvider.of<CollectBloc>(context)
                          .add(UserAddedItemsToMainList());
                    },
                    totalWeight: totalWeight,
                    totalPrice: totalPrice / 1000,
                    text: 'Add to List',
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MainCard extends StatelessWidget {
  final String title;
  final Function onTap;
  final IconData iconData;

  MainCard({this.title, this.onTap, this.iconData});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Icon(
                  iconData,
                  color: Color(0xFF6290EB),
                ),
                Text(
                  title,
                  style: TextStyle(
                      color: Color(0xFF454545),
                      fontSize: 17,
                      fontFamily: 'Lato Regular'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
