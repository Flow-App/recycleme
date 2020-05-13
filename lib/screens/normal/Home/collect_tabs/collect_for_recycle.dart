import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycleme/blocs/normal/collectTap/collect_bloc.dart';

class CollectForRecycle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if(BlocProvider
        .of<CollectBloc>(context).allSelectedItems.length>0){
      BlocProvider
          .of<CollectBloc>(context).add(BackToMainCollectTab());
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () {
              BlocProvider.of<CollectBloc>(context).add(GoToCategoreies());
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(90.0),
              ),
              elevation: 10,
              child: Container(
                padding: EdgeInsets.all(15),
                child: Icon(
                  FontAwesomeIcons.plus,
                  color: Color(0xFFC6D6F5),
                  size: 111,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 35,
          ),
          Text(
            'Collect For Recycle',
            style: TextStyle(
                color: Color(0xD9464646),
                fontSize: 20,
                fontFamily: 'Lato Regular'),
          )
        ],
      ),
    );
  }
}
