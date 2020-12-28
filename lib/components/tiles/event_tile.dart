import 'package:event_system/model/event.dart';
import 'package:flutter/material.dart';

class EventTile extends StatelessWidget{
  EventTile({
    Key key,
    this.event
  }) : super(key: key);

  final Event event;

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
                  minWidth: 160,
                  minHeight: 140,
                  maxWidth: 160,
                  maxHeight: 140,
                ),
                child: Image.network(event.image, fit: BoxFit.cover),
              ),),
            const Padding(padding: EdgeInsets.all(8.0)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 8.0, 2.0, 0.0),
                child: EventTileText(
                  event: event,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


class EventTileText extends StatelessWidget {
  EventTileText({
    Key key,
    this.event
  }) : super(key: key);

  final Event event;

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
                event.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 8.0)),
              Text(
                event.date,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black87,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 12.0)),
              Text(
                'Location: ' + event.location,
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