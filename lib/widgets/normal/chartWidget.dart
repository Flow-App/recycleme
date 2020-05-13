import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:recycleme/entities/UserEntity.dart';

// ignore: must_be_immutable
class ChartWidget extends StatelessWidget {
  final UserEntity user;
  final String frame;
  final Color _plasticColor = Color(0xFF99BCF3);
  final Color _paperColor = Color(0xFF77A54B);
  final Color _glassColor = Color(0xFFF06D76);
  final Color _tinColor = Color(0xFFD68E74);
  final Color _batteryColor = Color(0xFFDBBA56);

  List<double> plasticSpicke ;
  List<double> glassSpicke ;
  List<double> tinSpicke ;
  List<double> batterykSpickee ;
  List<double> paperSpicke ;

  ChartWidget({this.user, this.frame}){
    plasticSpicke = [0];
    glassSpicke = [0];
    tinSpicke = [0];
    batterykSpickee = [0];
    paperSpicke = [0];
    DateTime thisFrame;
    switch (frame) {
      case 'This Week':
        thisFrame = DateTime.now().subtract(new Duration(days: DateTime.now().weekday));
        break;
      case 'This Month':
        thisFrame = DateTime.now().subtract(new Duration(days: DateTime.now().day));

        break;
      case 'This Year':
        thisFrame = DateTime(DateTime.now().year, 1, 1).subtract(new Duration(days: 1));
        break;
    }
    user.transActions.forEach((transAction) {
      if(transAction.date.isAfter(thisFrame)){
        switch (transAction.type) {
          case 'plastic':
            plasticSpicke.add(transAction.amount);
            break;
          case 'glass':
            glassSpicke.add(transAction.amount);
            break;
          case 'tin':
            tinSpicke.add(transAction.amount);
            break;
          case 'paper':
            paperSpicke.add(transAction.amount);
            break;
          case 'battery':
            batterykSpickee.add(transAction.amount);
            break;
        }



      }
    });

  }




  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '- Paper',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Lato Regular',
                        color: _paperColor),
                  ),
                  Text(
                    '- Glass',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Lato Regular',
                        color: _glassColor),
                  ),
                  Text(
                    '- Plastic',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Lato Regular',
                        color: _plasticColor),
                  ),
                  Text(
                    '- Battery',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Lato Regular',
                        color: _batteryColor),
                  ),
                  Text(
                    '- Tin',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Lato Regular',
                        color: _tinColor),
                  )
                ],
              ),
              Stack(
                children: <Widget>[
                  Sparkline(
                    data: plasticSpicke,
                    lineColor: _plasticColor,
                  ),
                  Sparkline(
                    data: glassSpicke,
                    lineColor: _glassColor,
                  ),
                  Sparkline(
                    data: tinSpicke,
                    lineColor: _tinColor,
                  ),
                  Sparkline(
                    data: batterykSpickee,
                    lineColor: _batteryColor,
                  ),
                  Sparkline(
                    data: paperSpicke,
                    lineColor: _paperColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
