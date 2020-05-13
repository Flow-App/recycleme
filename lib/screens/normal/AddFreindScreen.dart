import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycleme/entities/UserEntity.dart';
import 'package:recycleme/repos/normal_repo.dart';
import 'package:recycleme/widgets/normal/AddFreindItem.dart';
import 'package:recycleme/widgets/normal/SearchInputFeild.dart';

class AddFriendScreen extends StatefulWidget {
  @override
  _AddFriendScreenState createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  List<UserEntity> users = [];
  String text;

  Future getter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      'Add Friend',
                      style: TextStyle(
                          fontFamily: 'Lato Bold',
                          fontSize: 30,
                          color: Color(0xFF4D525D)),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text('Search by name, phone number or email',
                  // TODO secach by ^
                  style: TextStyle(
                      fontFamily: 'Lato Regular',
                      fontSize: 18,
                      color: Color(0xD9232323))),
              SizedBox(
                height: 10,
              ),
                SearchInputField(
                padding: 30,
                hint: 'Search for a friend',
                onChanged: (val) {
                  text = val.toString().trim();
                  getter = Future.delayed(Duration(seconds: 2), () {
                    NormalRepo().getUsersByName(name: text).then((usersList) {
                      setState(() {
                        users = usersList;
                      });
                    });
                  });
                },
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return AddFriendItem(
                          index: index, userEntity: users[index]);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
