class AccessGroup{
  int id;
  String type;
  double price;
  String currency;
  int nb_tokens_available;

  AccessGroup(int id, String type, double price, String currency, int nbTokensAvailable){
    this.id = id;
    this.type = type;
    this.price = price;
    this.currency = currency;
    this.nb_tokens_available = nbTokensAvailable;
  }

  factory AccessGroup.fromMap(Map<String, dynamic> json) { 
      return AccessGroup(
         json['id'],
         json['type'], 
         json['price'], 
         json['currency'], 
         json['nbTokensAvailable'], 
      );
   }

   factory AccessGroup.fromJson(Map<String, dynamic> data) {
   return AccessGroup(
      data['id'],
      data['type'],
      data['price'], 
      data['currency'],
      data['nb_tokens_available'],
   );
   }


}