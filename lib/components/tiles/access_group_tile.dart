import 'package:event_system/model/access_group.dart';
import 'package:flutter/material.dart';

class AccessGroupTile extends StatelessWidget{
  AccessGroupTile({
    Key key,
    this.accessGroup,
    this.initials
  }) : super(key: key);

  final AccessGroup accessGroup;
  final String initials;

  @override
  Widget build(BuildContext context) {
    return new Container(
       height: 140.0,
       margin: const EdgeInsets.symmetric(
         vertical: 16.0,
         horizontal: 24.0,
       ),
      child: new Stack(
        children: <Widget>[
          AccessGroupText(accessGroup: accessGroup),
          AccessGroupThumbnail(accessGroup: accessGroup,),
        ],
      )
    );
}
}

class AccessGroupThumbnail extends StatelessWidget {
  AccessGroupThumbnail({
    Key key,
    this.accessGroup
  }) : super(key: key);

final AccessGroup accessGroup;

 @override
  Widget build(BuildContext context) {

    return Container(
      margin: new EdgeInsets.symmetric(
        vertical: 8.0
      ),
      alignment:  FractionalOffset.centerLeft,
      child: new CircleAvatar(
       backgroundColor: Colors.deepOrange,
       child: Text(accessGroup.type.substring(0,2).toUpperCase(),
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white), ),
       radius: 46,
        ),
    );
  }
}

class AccessGroupText extends StatelessWidget {
  AccessGroupText({
    Key key,
    this.accessGroup
  }) : super(key: key);

final AccessGroup accessGroup;

final headerTextStyle = const TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins'
    );

final positiveTextStyle = const TextStyle(
  color: Colors.green,
  fontSize: 14.0,
  fontWeight: FontWeight.w400,
  fontFamily: 'Poppins'
);

final negativeTextStyle = const TextStyle(
  color: Colors.red,
  fontSize: 14.0,
  fontWeight: FontWeight.w400,
  fontFamily: 'Poppins'
);

final subHeaderTextStyle = const TextStyle(
      color: Colors.black87,
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      fontFamily: 'Poppins'
    );

Text getAvailableText(int nbTokensAvailable){
  if(nbTokensAvailable > 0){
    return new Text("Available",
                style: positiveTextStyle,
              );
  }
  else{
    return new Text("Unvailable",
                style: negativeTextStyle,
              );
  }
}

 
 Widget getCardContent(BuildContext context) {
    return  Container(
     margin: new EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(height: 4.0),
          new Text(accessGroup.type,
            style: headerTextStyle,
          ),
          new Container(height: 10.0),
          new Text("Price: €" + accessGroup.price.toString(),
            style: subHeaderTextStyle

          ),
          new Container(
            margin: new EdgeInsets.symmetric(vertical: 8.0),
            height: 4.0,
            width: 18.0,
            color: new Color(0xff00c6ff)
          ),
          new Row(
            children: <Widget>[
              getAvailableText(accessGroup.nb_tokens_available),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context){
      return Container(
      child: getCardContent(context),
      height: 134.0,
      margin: new EdgeInsets.only(left: 46.0),
      decoration: new BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
    );
  }
}