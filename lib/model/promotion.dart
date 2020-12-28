import 'package:event_system/model/event.dart';
import 'package:event_system/model/ticket.dart';

class Promotion {
  Event event;
  num oldPrice;
  num newPrice;
  String ticketType;
  List<Ticket> tickets = [];

  Promotion(this.event, this.ticketType, this.oldPrice, this.newPrice);

  addTicket(Ticket ticket){
    tickets.add(ticket);
  }
}