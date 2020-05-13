String getConvertToStringDate({DateTime date}) {
  final DateTime now = DateTime.now();
  final int millis = now.millisecondsSinceEpoch - date.millisecondsSinceEpoch;
  if ((now.millisecondsSinceEpoch - 86400000) > date.millisecondsSinceEpoch) {
    // its a matter of days
    return '${millis / 86400000} days ago';
  } else if ((now.millisecondsSinceEpoch - 3600000) >
      date.millisecondsSinceEpoch) {
    // its matter of hours
    return '${millis / 3600000} hours ago';
  } else {
    // its matter of minutes
    return '${millis / 60000} minuets ago';
  }
}
