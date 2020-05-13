import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:recycleme/blocs/normal/collectTap/collect_bloc.dart';
import 'package:recycleme/entities/CPEntity.dart';
import 'package:recycleme/entities/ListItemEntity.dart';
import 'package:recycleme/repos/cpRepo.dart';

class ChoseCpToMakeADealWith extends StatefulWidget {
  @override
  _ChoseCpToMakeADealWithState createState() => _ChoseCpToMakeADealWithState();
}

class _ChoseCpToMakeADealWithState extends State<ChoseCpToMakeADealWith> {
  String ClosestId;

  @override
  Widget build(BuildContext context) {
    final list = BlocProvider.of<CollectBloc>(context).allSelectedItems;
    bool isLoading = false;
    return BlocListener(
      bloc: BlocProvider.of<CollectBloc>(context),
      listener: (context, state) {
        if (state is MakeingDealFeild) {
          setState(() {
            isLoading = false;
          });
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          body: SafeArea(
              child: Container(
            padding: const EdgeInsets.only(
              top: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        BlocProvider.of<CollectBloc>(context)
                            .add(BackToMainCollectTab());
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
                        'Collection Points',
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
                    child: FutureBuilder<List<CPEntity>>(
                  future: CpRepo().getApprovedCollectionPoints(),
                  builder: (context, snapShot) {
                    if (snapShot.hasError) {
                      return Center(
                        child: Text('Cheke Your internet Connection'),
                      );
                    } else if (snapShot.hasData) {
                      if (snapShot.data.length > 0) {
                        getClosestCp(snapShot.data).then((id) {
                          setState(() {
                            ClosestId = id;
                          });
                        });
                        return Container(
                          child: ListView.builder(
                              itemCount: snapShot.data.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                List<CPEntity> bestPrice = [];
                                bestPrice.addAll(snapShot.data);
                                bestPrice.sort((a, b) => a
                                    .getTotalItemsPrice(list)
                                    .compareTo(b.getTotalItemsPrice(list)));

                                return CpItem(
                                  index: index,
                                  closest: ClosestId,
                                  cp: snapShot.data.reversed.toList()[index],
                                  items: list,
                                  bestPrice: bestPrice.reversed.toList()[0].uid,
                                  onTap: () {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    BlocProvider.of<CollectBloc>(context).add(
                                        UserPickedCollectionPoint(snapShot
                                            .data.reversed
                                            .toList()[index]));
                                  },
                                );
                              }),
                        );
                      } else {
                        return Center(
                          child: Text('Cant find collection points'),
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
                ))
              ],
            ),
          )),
        ),
      ),
    );
  }
}

class CpItem extends StatefulWidget {
  final int index;
  final CPEntity cp;
  final List<ListItemEntity> items;
  final String closest;
  final String bestPrice;
  final Function onTap;

  CpItem({
    this.cp,
    this.index,
    this.onTap,
    this.items,
    this.bestPrice,
    this.closest,
  });

  @override
  _CpItemState createState() => _CpItemState();
}

class _CpItemState extends State<CpItem> {
  String distance = '';
  String price = '';

  @override
  void initState() {
    widget.cp.getDistanceBetweenUser().then((dist) {
      setState(() {
        distance = dist;
      });
    });
    price = widget.cp.getTotalItemsPrice(widget.items).toStringAsFixed(
        widget.cp.getTotalItemsPrice(widget.items).truncateToDouble() ==
                widget.cp.getTotalItemsPrice(widget.items)
            ? 0
            : 2);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: widget.onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              '${widget.index + 1}',
              style: TextStyle(
                  fontFamily: 'Lato Bold',
                  fontSize: 14,
                  color: Color(0xFF787878)),
            ),
            SizedBox(
              width: 13,
            ),
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
                child: Container(
                  padding:
                      EdgeInsets.only(left: 5, right: 10, top: 10, bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.cp.nameOfCompany,
                              style: TextStyle(
                                  fontFamily: 'Lato Bold',
                                  color: Color(0xFF4E525E),
                                  fontSize: 20),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  distance,
                                  style: TextStyle(
                                      fontFamily: 'Lato Regular',
                                      color: Color(0x994E525E),
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: <Widget>[
                                    Visibility(
                                      visible:
                                          widget.cp.uid == widget.bestPrice,
                                      child: Text(
                                        'best price',
                                        style: TextStyle(
                                            fontFamily: 'Lato Italic',
                                            color: Color(0xffFA9974),
                                            fontSize: 14),
                                      ),
                                    ),
                                    Visibility(
                                      visible: widget.cp.uid == widget.closest,
                                      child: Text(
                                        'Closest',
                                        style: TextStyle(
                                            fontFamily: 'Lato Italic',
                                            color: Color(0xFF5A79B3),
                                            fontSize: 14),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Text(
//                      TODO  the font
                        ' ₴ $price',
                        style: TextStyle(
                          color: Color(0xFF5A79B3),
                          fontSize: 30,
                        ),
                      )
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

Future<String> getClosestCp(List<CPEntity> cpList) async {
  String closestId = '';
  double closestDistance = double.infinity;
  for (int i = 0; i < cpList.length; i++) {
    double thisCpDistance = await cpList[i].getDistanceBetweenUserAsDouble();
    if (thisCpDistance < closestDistance) {
      closestDistance = thisCpDistance;
      closestId = cpList[i].uid;
    }
  }
  return closestId;
}
