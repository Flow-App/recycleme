class UserEntity {
  final String uid;
  final String email;
  final String name;
  final String age;
  final String gender;
  final String district;
  final String profilePic;
  final List<ItemTransAction> transActions;
  double totalToDisplay;


  UserEntity(
      {this.uid,
      this.email,
      this.name,
      this.age,
      this.gender,
      this.district,
      this.profilePic,
      this.transActions = const []}) ;



  double getTotalToDisplay() {
    return totalToDisplay;
  }

  double getThisWeekTransActions() {
    totalToDisplay = 0;
    DateTime today = DateTime.now();

    final _firstDayOfTheWeek =
        today.subtract(new Duration(days: today.weekday));
    this.transActions.forEach((transAction) {
      if (transAction.date.isAfter(_firstDayOfTheWeek)) {
        totalToDisplay += transAction.amount;
      }
    });
    return totalToDisplay;
  }

  double getThisMonthTransActions() {
    totalToDisplay = 0;
    final _lastDayofPreviousMonth =
        DateTime.now().subtract(new Duration(days: DateTime.now().day));
    this.transActions.forEach((transAction) {
      if (transAction.date.isAfter(_lastDayofPreviousMonth)) {
        totalToDisplay += transAction.amount;
      }
    });

    return totalToDisplay;
  }

  double getThisYearTransActions() {
    totalToDisplay = 0;
    DateTime lastDayOfBreivousYear =
        DateTime(DateTime.now().year, 1, 1).subtract(new Duration(days: 1));
    this.transActions.forEach((transAction) {
      if (transAction.date.isAfter(lastDayOfBreivousYear)) {
        totalToDisplay += transAction.amount;
      }
    });
    return totalToDisplay;
  }

  double getAllOfTimeTransActions() {
    totalToDisplay = 0;
    this.transActions.forEach((transAction) {
      totalToDisplay += transAction.amount;
    });
    return totalToDisplay;
  }
}

class ItemTransAction {
  final String type;
  final double amount;
  final double price;
  final DateTime date;

  ItemTransAction({this.type, this.amount, this.price, this.date});

  Map<String, dynamic> toMap() {
    return {
      'type': this.type,
      'amount': this.amount,
      'price': this.price,
      'date': this.date,
    };
  }
}
