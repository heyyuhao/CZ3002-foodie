enum DeliveryTime { TodayLunch, TodayDinner, TomorrowLunch, TomorrowDinner }

DateTime getOrderCut(DateTime orderStartTime) {
  return orderStartTime.subtract(Duration(hours: 1));
}

DateTime getTodayLunchTime() {
  DateTime now = new DateTime.now();
  return DateTime(now.year, now.month, now.day, 12);
}

DateTime getTodayDinnerTime() {
  DateTime now = new DateTime.now();
  return DateTime(now.year, now.month, now.day, 18);
}

DateTime getTomorrowLunchTime() {
  DateTime tomorrow = new DateTime.now().add(Duration(days: 1));
  return DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 12);
}

DateTime getTomorrowDinnerTime() {
  DateTime tomorrow = new DateTime.now().add(Duration(days: 1));
  return DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 18);
}

class DeliveryTimeChoice {
  DateTime _deliveryTimeStart;
  DateTime _deliveryTimeEnd;
  String _deliveryTimeStartStr;

  DeliveryTimeChoice(int deliveryTimeStartStr) {
    if (deliveryTimeStartStr == DeliveryTime.TodayLunch.index) {
      this._deliveryTimeStart = getTodayLunchTime();
      this._deliveryTimeEnd = getTodayLunchTime().add(Duration(hours: 1));
      this._deliveryTimeStartStr = "Today (12:00 - 13:00)";
    }

    if (deliveryTimeStartStr == DeliveryTime.TodayDinner.index) {
      this._deliveryTimeStart = getTodayDinnerTime();
      this._deliveryTimeEnd = getTodayDinnerTime().add(Duration(hours: 1));
      this._deliveryTimeStartStr = "Today (18:00 - 19:00)";
    }

    if (deliveryTimeStartStr == DeliveryTime.TomorrowLunch.index) {
      this._deliveryTimeStart = getTomorrowLunchTime();
      this._deliveryTimeEnd = getTomorrowLunchTime().add(Duration(hours: 1));
      this._deliveryTimeStartStr = "Tomorrow (12:00 - 13:00)";
    }

    if (deliveryTimeStartStr == DeliveryTime.TomorrowDinner.index) {
      this._deliveryTimeStart = getTomorrowDinnerTime();
      this._deliveryTimeEnd = getTomorrowDinnerTime().add(Duration(hours: 1));
      this._deliveryTimeStartStr = "Tomorrow (18:00 - 19:00)";
    }
  }

  String get deliveryTimeStartStr => _deliveryTimeStartStr;

  set deliveryTimeStartStr(String value) {
    _deliveryTimeStartStr = value;
  }

  DateTime get deliveryTimeEnd => _deliveryTimeEnd;

  set deliveryTimeEnd(DateTime value) {
    _deliveryTimeEnd = value;
  }

  DateTime get deliveryTimeStart => _deliveryTimeStart;

  set deliveryTimeStart(DateTime value) {
    _deliveryTimeStart = value;
  }
}

List<DeliveryTimeChoice> getDeliveryTimeChoices() {
  List<DeliveryTimeChoice> deliveryTimeChoices = [];
  DateTime now = new DateTime.now();

  if (now.compareTo(getOrderCut(getTodayLunchTime())) < 0) {
    // can order today's lunch
    deliveryTimeChoices.add(DeliveryTimeChoice(DeliveryTime.TodayLunch.index));
  }
  if (now.compareTo(getOrderCut(getTodayDinnerTime())) < 0) {
    // can order today's dinner
    deliveryTimeChoices.add(DeliveryTimeChoice(DeliveryTime.TodayDinner.index));
  }
  deliveryTimeChoices.add(DeliveryTimeChoice(DeliveryTime.TomorrowLunch.index));
  deliveryTimeChoices
      .add(DeliveryTimeChoice(DeliveryTime.TomorrowDinner.index));

  return deliveryTimeChoices;
}
