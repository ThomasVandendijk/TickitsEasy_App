import 'package:event_system/model/user.dart';

class Subscription{
  String startDate;
  String endDate;
  User owner;
  String club;
  String ticketType;
  String imageName;

  Subscription(this.startDate, this.endDate, this.owner, this.club, this.ticketType, this.imageName);
}