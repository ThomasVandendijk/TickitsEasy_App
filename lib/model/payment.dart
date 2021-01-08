class PaymentsConfig{
  String publicKey;

  PaymentsConfig(this.publicKey);

  factory PaymentsConfig.fromMap(Map<String, dynamic> json) { 
      return PaymentsConfig(
         json['publicKey'],
      );
   }

   factory PaymentsConfig.fromJson(Map<String, dynamic> data) {
   return PaymentsConfig(
      data['publicKey'],
   );
   }
}

class PaymentSession{
  String sessionId;

  PaymentSession(this.sessionId);

  factory PaymentSession.fromMap(Map<String, dynamic> json) { 
      return PaymentSession(
         json['sessionId'],
      );
   }

   factory PaymentSession.fromJson(Map<String, dynamic> data) {
   return PaymentSession(
      data['sessionId'],
   );
   }
}