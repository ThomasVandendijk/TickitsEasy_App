import 'package:event_system/model/promotion.dart';
import 'package:flutter/material.dart';

class PromotionTile extends StatelessWidget{
  PromotionTile({
    Key key,
    this.promotion
  }) : super(key: key);

  final Promotion promotion;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: SizedBox(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.2,
              child: CircleAvatar(
                backgroundImage: AssetImage(promotion.event.image),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                child: PromotionTileText(
                  promotion: promotion,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


class PromotionTileText extends StatelessWidget {
  PromotionTileText({
    Key key,
    this.promotion
  }) : super(key: key);

  final Promotion promotion;

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
                promotion.event.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 8.0)),
              Text(
                promotion.event.date,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.black54,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 8.0)),
              Text(
                "Type:" + promotion.ticketType,
                style: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.black54,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 8.0)),
              Row(
                children: <Widget>[
                  Text(
                    'Price: €' + promotion.oldPrice.toString(),
                    style: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.black54,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: Colors.red,
                      decorationThickness: 2.0,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(left: 10.0, top: 10)),
                  Text(
                    'Price: €' + promotion.newPrice.toString(),
                    style: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    ],
  );
  }
}