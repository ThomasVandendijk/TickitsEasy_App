import 'package:event_system/components/popups/ays_popup.dart';
import 'package:event_system/components/tiles/subscription_tile.dart';
import 'package:event_system/model/access_group.dart';
import 'package:event_system/model/event.dart';
import 'package:event_system/model/my_access_token.dart';
import 'package:event_system/model/promotion.dart';
import 'package:event_system/components/tiles/promotion_tile.dart';
import 'package:event_system/model/subscription.dart';
import 'package:event_system/components/tiles/ticket_tile.dart';
import 'package:event_system/components/tiles/event_tile.dart';
import 'package:event_system/pages/buy_pages/access_group_page.dart';
import 'package:flutter/material.dart';
import 'package:event_system/pages/ticket_detail_page.dart';
import 'package:event_system/components/popups/popup.dart';
import 'package:event_system/components/tiles/access_group_tile.dart';


GestureDetector createEventCard(BuildContext context, Event event){
  return GestureDetector(
          child: Card(
            child: EventTile(event: event,)
          ),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => new AccessGroupPage(event.id, event.title)));},
          );
}

GestureDetector createAccessGroupCard(BuildContext context, AccessGroup accessGroup, int eventId){
  return GestureDetector(
          child: AccessGroupTile(accessGroup: accessGroup, initials: accessGroup.type.substring(0,2)),
          onTap: (){
            showDialog(
              context: context,
              builder: (BuildContext context) => CustomDialog(accessGroup: accessGroup, eventId: eventId,),
                    );
               }
        );
    }
GestureDetector createTicketCard(BuildContext context, MyAccessToken myAccessToken){
  return GestureDetector(
          child: Card(
            child: TicketTile(myAccessToken: myAccessToken,)
          ),
          onTap: () async{
            String dataString = await generateNewQR(myAccessToken.id);
            Navigator.push(context, MaterialPageRoute(builder: (context) => TicketDetailPage(myAccessToken: myAccessToken, dataString: dataString,)));},
          );
}

GestureDetector createTicketSelectionCard(BuildContext context, MyAccessToken myAccessToken){
  return GestureDetector(
          child: Card(
            child: TicketTile(myAccessToken: myAccessToken,)
          ),
          onTap: () {
            showAYSDialog(context, myAccessToken);}
          );
}

GestureDetector createTicketAnnulationCard(BuildContext context, MyAccessToken myAccessToken){
 
  return GestureDetector(
          child: Card(
            child: TicketTile(myAccessToken: myAccessToken,)
          ),
          onLongPress: () {
            showCancelDialog(context, myAccessToken);}
          );
}

GestureDetector createPromotionCard(BuildContext context, Promotion promotion){
  return GestureDetector(
          child: Card(
            child: PromotionTile(promotion: promotion,)
          ),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => TicketDetailPage()));},
          );
}

GestureDetector createSubscriptionCard(BuildContext context, Subscription subscription){
  return GestureDetector(
          child: Card(
            child: SubscriptionTile(subscription: subscription,)
          ),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => TicketDetailPage()));},
          );

}