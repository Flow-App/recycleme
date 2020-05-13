import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycleme/entities/UserEntity.dart';
import 'package:recycleme/repos/normal_repo.dart';
import 'package:recycleme/screens/normal/settings/Settings.dart';
import 'package:recycleme/screens/normal/NotificationsScreen.dart';
import 'package:recycleme/widgets/normal/TimeFramePicker.dart';
import 'package:recycleme/widgets/normal/chartWidget.dart';
import 'package:recycleme/widgets/normal/topBoard.dart';

class AccountTab extends StatefulWidget {
  final UserEntity currentUser;

  AccountTab(this.currentUser);

  @override
  _AccountTabState createState() => _AccountTabState();
}

class _AccountTabState extends State<AccountTab> {
  Widget chart;

  double totalPlastic = 0;
  List<double> plasticSpickes = [0];
  double totalGlass = 0;
  List<double> glassSpickes = [0];
  double totalTin = 0;
  List<double> tinSpickes = [0];
  double totalBattery = 0;
  List<double> batterykSpickes = [0];
  double totalPaper = 0;
  List<double> paperSpickes = [0];
  double totalPrice = 0;
  double totalKg = 0;

  void startCalculating() async {
    setState(() {
      widget.currentUser.transActions.forEach((transAction) {
        totalPrice += transAction.price;
        totalKg += transAction.amount;
        switch (transAction.type) {
          case 'plastic':
            totalPlastic += transAction.amount;
            plasticSpickes.add(transAction.amount);
            break;
          case 'glass':
            totalGlass += transAction.amount;
            glassSpickes.add(transAction.amount);
            break;
          case 'tin':
            totalTin += transAction.amount;
            tinSpickes.add(transAction.amount);
            break;
          case 'paper':
            totalPaper += transAction.amount;
            paperSpickes.add(transAction.amount);
            break;
          case 'battery':
            totalBattery += transAction.amount;
            batterykSpickes.add(transAction.amount);
            break;
        }
      });
    });
  }

  @override
  void initState() {
    startCalculating();
    chart = ChartWidget(user: widget.currentUser, frame: 'This Week');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(160),
                  ),
                  gradient: LinearGradient(colors: [
                    Color(0xFF73D07A),
                    Color(0xFF48A64F),
                  ])),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 15, right: 10),
                child: Column(
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.transparent,
                                backgroundImage:
                                    NetworkImage(widget.currentUser.profilePic),
                              ),
                              SizedBox(width: 10),
                              Text(
                                widget.currentUser.name,
                                style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'Lato Bold',
                                    color: Colors.white),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              FutureBuilder(
                                  future: NormalRepo()
                                      .getCurrentUserNotificationsCount(),
                                  builder: (context, snapShot) {
                                    if (snapShot.hasError) {
                                      return SizedBox();
                                    } else if (snapShot.hasData &&
                                        snapShot.data > 0) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return NotificationsScreen();
                                          }));
                                        },
                                        child: Badge(
                                          badgeColor: Color(0xFFFF1212),
                                          badgeContent: Text(
                                            snapShot.data.toString(),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          child: Icon(
                                            FontAwesomeIcons.solidBell,
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return NotificationsScreen();
                                          }));
                                        },
                                        child: Icon(
                                          FontAwesomeIcons.solidBell,
                                          color: Colors.white,
                                        ),
                                      );
                                    }
                                  }),
                              SizedBox(width: 20),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Settings();
                                  }));
                                },
                                icon: Icon(
                                  FontAwesomeIcons.cog,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ]),
                    TopBoard(
                      battery: totalBattery,
                      glass: totalGlass,
                      paper: totalPaper,
                      plastic: totalPlastic,
                      tin: totalTin,
                      price: totalPrice,
                      total: totalKg,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TimeFramePicker(
              omFrameChanged: (newFrame) {
                setState(() {
                  chart =
                      ChartWidget(user: widget.currentUser, frame: newFrame);
                  print(newFrame);
                });
              },
            ),
            chart
          ],
        ),
      ),
    );
  }
}
