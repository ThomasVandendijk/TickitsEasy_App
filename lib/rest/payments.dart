import 'package:event_system/model/payment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


PaymentsConfig parsePaymentsConfig(String responseBody) { 
   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>(); 
   return parsed.map<PaymentsConfig>((json) =>PaymentsConfig.fromJson(json));
} 

Future<PaymentsConfig> fetchPaymentPublicKey(String configUrl) async{
  final response = await http.get(configUrl); 
   if (response.statusCode == 200) { 
      print(response.body);
      return parsePaymentsConfig(response.body); 
   } else { 
      throw Exception('Unable to fetch the payment configuration');
   } 
}

PaymentSession parsePaymentSession(String responseBody){
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>(); 
  return parsed.map<PaymentSession>((json) =>PaymentSession.fromJson(json));
}

