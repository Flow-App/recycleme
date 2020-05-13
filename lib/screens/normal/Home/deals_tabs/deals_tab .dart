import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycleme/blocs/normal/deals_bloc/deals_bloc.dart';
import 'package:recycleme/entities/DealEntity.dart';
import 'package:recycleme/repos/deals_rebo.dart';
import 'package:recycleme/screens/normal/Home/deals_tabs/deal_details_screen.dart';

class DealsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.only(top: 15, left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Deals',
              style: TextStyle(
                  fontFamily: 'Lato Bold',
                  fontSize: 30,
                  color: Color(0xFF4D525D)),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: FutureBuilder<List<DealEntity>>(
                future: DealsRepo().getUserDeals(),
                builder: (context, snapShot) {
                  if (snapShot.hasError) {
                    return Center(
                      child: Text('Cheke Your internet Connection'),
                    );
                  } else if (snapShot.hasData) {
                    if (snapShot.data.length > 0) {
                      return Container(
                        child: ListView.builder(
                            itemCount: snapShot.data.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return DealItem(
                                  index: index, deal: snapShot.data[index]);
                            }),
                      );
                    } else {
                      return Center(
                        child: Text(' You Have No Deals Yet'),
                      );
                    }
                  } else {
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}

class DealItem extends StatelessWidget {
  final int index;
  final DealEntity deal;

  DealItem({this.deal, this.index});

  @override
  Widget build(BuildContext context) {
    Icon statusIcon;
    switch (deal.status) {
      case DealStatus.in_process:
        statusIcon = Icon(
          FontAwesomeIcons.arrowCircleUp,
          color: Colors.green,
        );
        break;
      case DealStatus.accepted:
        statusIcon = Icon(
          FontAwesomeIcons.check,
          color: Colors.yellow,
        );
        break;
      case DealStatus.rejected:
        statusIcon = Icon(
          FontAwesomeIcons.times,
          color: Colors.red,
        );
        break;
      case DealStatus.done:
        statusIcon = Icon(
          FontAwesomeIcons.dollarSign,
          color: Colors.blueAccent,
        );
        break;
    }
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          BlocProvider.of<DealsBloc>(context).add(GoToDealProfile(deal));
        },
        child: Row(
          children: <Widget>[
            Text(
              '${index + 1}',
              style: TextStyle(
                  fontFamily: 'Lato Bold',
                  fontSize: 20,
                  color: Color(0xFF787878)),
            ),
            SizedBox(
              width: 13,
            ),
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Container(
                  margin: EdgeInsets.all(15),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              deal.cpName,
                              style: TextStyle(
                                  fontFamily: 'Lato Bold',
                                  color: Color(0xFF4E525E),
                                  fontSize: 20),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              deal.formatDate(),
                              style: TextStyle(
                                  fontFamily: 'Lato Regular',
                                  color: Color(0x994E525E),
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      statusIcon,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
