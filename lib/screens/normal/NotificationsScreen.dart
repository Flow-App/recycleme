import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:recycleme/entities/NotificationEntity.dart';
import 'package:recycleme/repos/normal_repo.dart';
import 'package:recycleme/widgets/normal/FreindRequestItem.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
          body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
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
                      'Notifications',
                      style: TextStyle(
                          fontFamily: 'Lato Bold',
                          fontSize: 30,
                          color: Color(0xFF4D525D)),
                    ),
                  ),
                  Icon(
                    FontAwesomeIcons.solidBell,
                    color: Color(0xFF7994E2),
                  ),
                  SizedBox(
                    width: 70,
                  )
                ],
              ),
              FutureBuilder<List<NotificationEntity>>(
                future: NormalRepo().getUsersNotifications(),
                builder: (context, snapShot) {
                  if (snapShot.hasData) {
                    return Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ListView.builder(
                                  itemCount: snapShot.data.length,
                                  itemBuilder: (context, index) {
                                    if (index == 0) {
                                      return Card(
                                          child: FriendRequestItem(
                                        request: snapShot.data[index],
                                        onAddClicked:() async {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          await NormalRepo().acceptFriendRequest(id: snapShot.data[index].uid);
                                          setState(() {
                                            isLoading = false;
                                          });
                                        },
                                        onIgnoreClicked: () async {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          await NormalRepo().ignoreFreindRequest(id: snapShot.data[index].uid);
                                          setState(() {
                                            isLoading = false;
                                          });
                                        },
                                      ));
                                    } else {
                                      switch (snapShot.data[index].type) {
                                        case 'friend':
                                          return FriendRequestItem(
                                            request: snapShot.data[index],
                                          );
                                          break;
                                        default:
                                          return SizedBox();
                                      }
                                    }
                                  }),
                            )
                          ]),
                    );
                  } else if (snapShot.hasError) {
                    return Center(
                      child: Text('network error'),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
