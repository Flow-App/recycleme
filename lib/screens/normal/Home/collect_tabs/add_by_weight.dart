import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycleme/blocs/normal/collectTap/collect_bloc.dart';

class AddbyWeight extends StatefulWidget {
  @override
  _AddbyWeightState createState() => _AddbyWeightState();
}

class _AddbyWeightState extends State<AddbyWeight> {
  String weight;

  @override
  Widget build(BuildContext context) {
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
                            .add(BackToTypesScreen());
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
                        'Add Recyables by wieght',
                        style: TextStyle(
                            fontFamily: 'Lato Bold',
                            fontSize: 28,
                            color: Color(0xFF4D525D)),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 25,),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 1,
                            color: const Color(0xffEBEBEB),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(16.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                            onChanged: (val) {
                              weight = val;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Weight By grams',

                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 25,),
                    RaisedButton(
                      color: Colors.amber,
                      elevation: 5,
                      child: Text('Add'),
                      onPressed: () {
                        BlocProvider.of<CollectBloc>(context)
                            .add(UserAddedByWeight(int.parse(weight)));
                      },
                    )
                  ],
                )
              ])),
    ));
  }
}
//UserAddedByWeight
