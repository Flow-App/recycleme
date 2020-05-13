import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycleme/blocs/normal/collectTap/collect_bloc.dart';
import 'package:recycleme/entities/ListItemEntity.dart';

class ListItemWidget extends StatelessWidget {
  final ListItemEntity item;

  ListItemWidget(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.brand.brandName,
                  style: TextStyle(
                      fontFamily: 'Lato Regular',
                      fontSize: 20,
                      color: Color(0xff464646)),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      '${item.brand.weight} g',
                      style: TextStyle(color: Color(0xff9F9F9F)),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      '${item.brand.price} ~UAH',
                      style: TextStyle(color: Color(0xff73BB58)),
                    )
                  ],
                )
              ],
            ),
          ),
          PlusMinWidget(item),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}

class PlusMinWidget extends StatefulWidget {
  final ListItemEntity item;

  PlusMinWidget(this.item);

  @override
  _PlusMinWidgetState createState() => _PlusMinWidgetState();
}

class _PlusMinWidgetState extends State<PlusMinWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () {
              BlocProvider.of<CollectBloc>(context)
                  .add(ListItemMinMin(widget.item));
            },
            child: Icon(
              FontAwesomeIcons.minus,
              color: Color(0xFF252525),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            widget.item.quntity.toString(),
            style: TextStyle(
                color: Color(0xFF252525),
                fontSize: 20,
                fontFamily: 'Lato Regular'),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              BlocProvider.of<CollectBloc>(context)
                  .add(ListItemPlusPlus(widget.item));
            },
            child: Icon(
              FontAwesomeIcons.plus,
              color: Color(0xFF252525),
            ),
          ),
        ],
      ),
    );
  }
}
