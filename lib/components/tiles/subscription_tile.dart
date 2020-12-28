import 'package:event_system/model/subscription.dart';
import 'package:flutter/material.dart';

class SubscriptionTile extends StatelessWidget{
  SubscriptionTile({
    Key key,
    this.subscription
  }) : super(key: key);

  final Subscription subscription;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: SizedBox(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Padding(padding: EdgeInsets.all(8.0)),
            Center(
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 50,
                  minHeight: 50,
                  maxWidth: 100,
                  maxHeight: 100,
                ),
                child: Image.asset(subscription.imageName, fit: BoxFit.cover),
              ),),
            const Padding(padding: EdgeInsets.all(8.0)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 8.0, 2.0, 0.0),
                child: SubscriptionTileText(
                  subscription: subscription,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


class SubscriptionTileText extends StatelessWidget {
  SubscriptionTileText({
    Key key,
    this.subscription
  }) : super(key: key);

  final Subscription subscription;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Subscription: " + subscription.club,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 8.0)),
              Text(
                "Start date: " + subscription.startDate,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 4.0)),
              Text(
                "End date: " + subscription.startDate,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 8.0)),
              Text(
                "Ticket type: " + subscription.ticketType,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}