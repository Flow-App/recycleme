import 'package:recycleme/entities/ListItemEntity.dart';
enum DealStatus {
  in_process,
  accepted,
  rejected,
  done,
}

class DealEntity {
  final String cpName;
  final String cpID;
  final DateTime date;
  final String uid;
  final DealStatus status;
  final List<ListItemEntity> dealItems;

  DealEntity({this.cpName, this.cpID, this.date, this.status, this.dealItems,this.uid});

  String formatDate() {
    String day = date.day.toString();
    String month;
    switch (date.month) {
      case 1:
        month = 'January';
        break;
      case 2:
        month = 'February';
        break;
      case 3:
        month = 'March';
        break;
      case 4:
        month = 'April';
        break;
      case 5:
        month = 'May';
        break;
      case 6:
        month = 'June';
        break;
      case 7:
        month = 'July';
        break;
      case 8:
        month = 'August';
        break;
      case 9:
        month = 'September';
        break;
      case 10:
        month = 'October';
        break;
      case 11:
        month = 'November';
        break;
      case 12:
        month = 'December';
        break;
    }
    return'$day $month';
  }
}
