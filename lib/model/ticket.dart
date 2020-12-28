import 'package:event_system/model/event.dart';
import 'package:event_system/model/user.dart';

class Ticket{
  User owner;
  Event event;
  String seat;
  num price;

  Ticket(this.owner, this.event, this.seat, this.price);
}