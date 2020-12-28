import 'package:event_system/model/my_access_token.dart';
import 'package:flutter/material.dart';

class TicketTile extends StatelessWidget{
  TicketTile({
    Key key,
    this.myAccessToken
  }) : super(key: key);

  final MyAccessToken myAccessToken;

  @override
  Widget build(BuildContext context) {
    double screenHeight = (MediaQuery.of(context).size.height);
    double screenWidth = (MediaQuery.of(context).size.width);
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
                  minWidth: 0.33*screenWidth,
                  minHeight: 140,
                  maxWidth: 0.33*screenWidth,
                  maxHeight: 160,
                ),
                child: Image.network(myAccessToken.event_image, fit: BoxFit.cover),
              ),),
            const Padding(padding: EdgeInsets.all(8.0)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 8.0, 2.0, 0.0),
                child: TicketTileText(
                  myAccessToken: myAccessToken,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TicketTileText extends StatelessWidget {
  TicketTileText({
    Key key,
    this.myAccessToken
  }) : super(key: key);

  final MyAccessToken myAccessToken;

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
                myAccessToken.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                myAccessToken.date,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                "Type:" + myAccessToken.type,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black87,
                ),
              ),
              Text(
                'Price: €' + myAccessToken.price.toString(),
                style: const TextStyle(
                  fontSize: 12.0,
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