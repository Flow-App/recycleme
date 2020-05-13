import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycleme/entities/UserEntity.dart';
import 'package:recycleme/repos/normal_repo.dart';
import 'package:recycleme/screens/normal/AddFreindScreen.dart';
import 'package:recycleme/widgets/normal/RatingDurationPicker.dart';
import 'package:recycleme/widgets/normal/RatingItem.dart';

class RatingsTab extends StatefulWidget {
  final UserEntity currentUser;

  RatingsTab(this.currentUser);

  @override
  _RatingsTabState createState() => _RatingsTabState();
}

class _RatingsTabState extends State<RatingsTab> {
  List<UserEntity> users = [];
  int currentUserIndex = 0;
  bool isLoading = true;
  UserEntity currentUser;

  @override
  void initState() {
    currentUser = widget.currentUser;
    NormalRepo().getUsersFriendsByRating().then((usersList) {
      setState(() {
        users = usersList;
        _changeDuration('Week');
      });
    });
    super.initState();
  }

  void _changeDuration(duration) async {
    print(currentUser.transActions.length);

    setState(() {
      isLoading = true;
    });
    switch (duration) {
      case 'Week':
        users.sort((a, b) =>
            a.getThisWeekTransActions().compareTo(b.getThisWeekTransActions()));

        break;
      case 'Month':
        users.sort((a, b) => a
            .getThisMonthTransActions()
            .compareTo(b.getThisMonthTransActions()));

        break;
      case 'Year':
        users.sort((a, b) =>
            a.getThisYearTransActions().compareTo(b.getThisYearTransActions()));

        break;
      case 'All of Time':
        users.sort((a, b) => a
            .getAllOfTimeTransActions()
            .compareTo(b.getAllOfTimeTransActions()));

        break;
    }
    setState(() {
      isLoading = false;
      users = users.reversed.toList();
      for (int i = 0; i < users.length; i++) {
        if (users[i].uid == widget.currentUser.uid) {
          currentUser.totalToDisplay = users[i].totalToDisplay;
          print(currentUser.totalToDisplay);
          print(currentUser.transActions.length);

          currentUserIndex = i;
          break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Top Ratings',
                      style: TextStyle(
                          fontFamily: 'Lato Bold',
                          fontSize: 30,
                          color: Color(0xFF4D525D)),
                    ),
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.userPlus),
                    color: Color(0xFF4D525D),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AddFriendScreen();
                      }));
                    },
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
            ),
            Visibility(
              visible: isLoading,
              child: Container(
                height: size.height - 60,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            RatingDurationPicker(
              onDurationChanged: _changeDuration,
            ),
           Expanded(
             child: Container(
               child: SingleChildScrollView(
                 child: Column(
                   children: <Widget>[
                     Card(
                       elevation: 5,
                         child: RatingItem(
                           index: currentUserIndex,
                           userEntity: currentUser,
                         )),
                     Container(
                       child: ListView.builder(
                         shrinkWrap: true,
                           physics: NeverScrollableScrollPhysics(),
                           itemCount: users.length,
                           itemBuilder: (context, index) {
                             return RatingItem(
                               index: index,
                               userEntity: users[index],
                             );
                           }),
                     )
                   ],
                 ),
               ),
             ),
           )
          ],
        ),
      ),
    );
  }
}
