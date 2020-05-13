import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycleme/blocs/normal/collectTap/collect_bloc.dart';
import 'package:recycleme/entities/ListItemEntity.dart';
import 'package:recycleme/widgets/normal/SearchInputFeild.dart';
import 'package:recycleme/config.dart';

import 'collectContainer.dart';
import 'list_item_widget.dart';

class SelectedItems extends StatefulWidget {






  @override
  _AddToListState createState() => _AddToListState();
}

class _AddToListState extends State<SelectedItems> {
  Category selectedCategory;
  String title;
  String searchText;
  List<ListItemEntity> items = [];


  @override
  Widget build(BuildContext context) {
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
    return BlocListener<CollectBloc, CollectState>(
      listener: (_, state) {
        if (state is AddListChanged) {
          setState(() {
            items = state.list;
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
                  padding: 15,
                  onChanged: (val) {
                    searchText = val;
                  },
                  hint: 'Search for brand',
                  onComplete: () {},
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(width: 20),
                    MainCard(
                      onTap: () {
                        BlocProvider.of<CollectBloc>(context)
                            .add(AddByType());
                      },
                      iconData: FontAwesomeIcons.weightHanging,
                      title: 'Select Weight',
                    ),
                    SizedBox(width: 20),
                    MainCard(
                      onTap: () {},
                      iconData: FontAwesomeIcons.solidHeart,
                      title: 'Favorites',
                    ),
                    SizedBox(width: 20),
                  ],
                ),
                Expanded(
                  child: CollectContainer(
                    child: ListView.builder(
                      itemCount: items.length,
                        itemBuilder: (context, index) {
                      return ListItemWidget(items[index]);
                    }),
                    onPress: () {},
//                    totalWeight: '20',
//                    totalPrice: '50',
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
                      fontSize: 18,
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
