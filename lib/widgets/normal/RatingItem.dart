import 'package:flutter/cupertino.dart';
import 'package:recycleme/entities/UserEntity.dart';

class RatingItem extends StatelessWidget {
  final int index;
  final UserEntity userEntity;

  RatingItem({this.userEntity, this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
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
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.network(
              userEntity.profilePic,
              width: 73,
              height: 73,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${userEntity.name} ',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Lato Bold',
                      color: Color(0xFF151515)),
                ),
                Text(
                  '${userEntity.district} ,Ukraine',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Lato Regular',
                      color: Color(0xFF636363)),
                )
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Text(
                getTotal(),
                style: TextStyle(
                    fontFamily: 'Lato Bold',
                    color: Color(0xffFA9974),
                    fontSize: 30),
              ),
              Text(
                ' kg',
                style: TextStyle(
                    fontFamily: 'Lato Regular',
                    color: Color(0xffFA9974),
                    fontSize: 18),
              ),
            ],
          )
        ],
      ),
    );
  }

  String getTotal() {
    try {
      return userEntity.getTotalToDisplay().toStringAsFixed(
          userEntity.getTotalToDisplay().truncateToDouble() ==
                  userEntity.getTotalToDisplay()
              ? 0
              : 1);
    } catch (e) {
      return '0';
    }
  }
}
