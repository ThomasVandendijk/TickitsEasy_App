import 'package:event_system/model/payment.dart';
import 'package:event_system/pages/buy_pages/checkout_page.dart';
import 'package:event_system/rest/registrate.dart' as prefix0;
import 'package:event_system/utils/settings.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:event_system/rest/login.dart';
import 'dart:io';
import 'dart:convert';
import 'package:event_system/rest/payments.dart';

void buyToken(BuildContext context, int eventId, int agId, int requestAmount) async {
  PaymentsConfig paymentsConfig = await fetchPaymentPublicKey(URLs().paymentsConfigUrl);
  http.Response response = await attemptBuyToken(eventId, agId, requestAmount);
  if(response.statusCode == 201) {
    PaymentSession paymentSession = parsePaymentSession(response.body);
    redirectToCheckout(context, paymentSession.sessionId, paymentsConfig.publicKey);
    
  }
  else{
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    String message = parsed['message'];
    displayDialog(context, "Error", message);
  }
}

Future<http.Response> attemptBuyToken(int eventId, int agId, int requestAmount) async{
  String host = getHost();
  String url = host + URLs().getAccessGroupDetailUrl(eventId, agId);
  final storage = new FlutterSecureStorage();
  var authToken = await storage.read(key: 'authToken');
  print(requestAmount);
  var res = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Token $authToken',
      },
      body: {
        "request_amount": json.encode(requestAmount),
      }
    );
  return res;
}