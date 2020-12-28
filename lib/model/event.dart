class Event {
  int id;
  String title;
  String date;
  String location;
  String image;

  Event(int id, String title, String date, String location, String image){
    this.id = id;
    this.title = title;
    this.date = date;
    this.location = location;
    this.image = image;
  }

  factory Event.fromMap(Map<String, dynamic> json) { 
      return Event(
         json['id'], 
         json['title'], 
         json['date'], 
         json['location'], 
         json['image'], 
      );
   }

   factory Event.fromJson(Map<String, dynamic> data) {
   return Event(
      data['id'],
      data['title'],
      data['date'], 
      data['location'],
      data['image'],
   );
   }


}