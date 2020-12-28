import 'package:event_system/model/my_access_token.dart';

String getHost(){
  return "https://f3cxrfevre.execute-api.eu-west-3.amazonaws.com/dev";
  //return "http://10.0.2.2:8000";
}

class URLs {
  String accessCheck = "/access_check/";
  String sellableTokens = "/sellable_tokens/";
  String globalEvents = "/events/";
  String mySellTokens = "/sell_tokens/";
  String myAccessTokens = "/access_tokens/";
  String mnemonicUrl = "/user_details/";
  String publicAddressUrl = "/public_address/";
  String login = "/rest-auth/login/";
  String registration = "/rest-auth/registration/";
  String logout = "/rest-auth/logout/";
  String migrateUserDetails = "/migrate/user_details";
  String migrateAction = "/migrate/action";
  String deviceStatus = "/migrate/deviceStatus";
  
  String getSellMySellTokenUrl(MyAccessToken myAccessToken) => "/sell_tokens/" + myAccessToken.id.toString() + "/sell/";
  String getCancelSaleSellToken(MyAccessToken myAccessToken) => "/sell_tokens/" + myAccessToken.id.toString() + "/cancel/";
  String getAccessGroupUrl(int eventId) =>  "/events/" + eventId.toString() + "/access_group/" ;
  String getAccessGroupDetailUrl(int eventId, int agId) => "/events/$eventId/access_group/$agId/";
  String getEventSearchUrl(String query) => "/events/?search=" + query;
  String getAccessTokenSearchUrl(String query) => "/access_tokens/?search=" + query;
}