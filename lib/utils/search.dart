import 'package:event_system/components/build_card.dart';
import 'package:event_system/model/event.dart';
import 'package:event_system/model/my_access_token.dart';
import 'package:event_system/pages/bottom_appbar/event_page.dart';
import 'package:event_system/pages/drawer/my_tickets_page.dart';
import 'package:event_system/rest/event_factory.dart';
import 'package:event_system/rest/my_tickets.dart';
import 'package:event_system/utils/settings.dart';
import 'package:flutter/material.dart';

class EventSearch extends SearchDelegate<String>{

  Future<List<Event>> recentSearch = Future.value([]);

  @override
  List<Widget> buildActions(BuildContext context) {
    // actions for app bar
    return [IconButton(icon: Icon(Icons.clear), onPressed: (){
      query = "";
    })];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of the app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    String url = getHost() + URLs().getEventSearchUrl(query);
    Future<List<Event>> suggestionEvents = query.isEmpty?recentSearch:fetchEvents(url);
    

    return Center(
        child: FutureBuilder<List<Event>>(
            future: suggestionEvents, builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error); 
              return snapshot.hasData ? EventPageState(items: snapshot.data): 
              
              // return the ListView widget : 
              Center(child: CircularProgressIndicator()); 
            },
        ),
      );
  }

    Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something
      return ListView();
    }

}

class MyTicketsSearch extends SearchDelegate<String>{

  Future<List<Event>> recentSearch = Future.value([]);

  @override
  List<Widget> buildActions(BuildContext context) {
    // actions for app bar
    return [IconButton(icon: Icon(Icons.clear), onPressed: (){
      query = "";
    })];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of the app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    String url = getHost() + URLs().getAccessTokenSearchUrl(query);
    Future<List<MyAccessToken>> suggestionEvents = query.isEmpty?recentSearch:fetchMyAccessTokens(url);
    

    return Center(
        child: FutureBuilder<List<MyAccessToken>>(
            future: suggestionEvents, builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error); 
              return snapshot.hasData ? MyTicketsPageState(items: snapshot.data): 
              
              // return the ListView widget : 
              Center(child: CircularProgressIndicator()); 
            },
        ),
      );
  }

    Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something
      return ListView();
    }

 /* @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something
    String url = getHost() + "/events/?search=" + query;
    Future<List<Event>> suggestionEvents;
    setState(){
      suggestionEvents = query.isEmpty?recentSearch:fetchEvents(url);
    }
     
    return FutureBuilder<List<Event>>(
            future: suggestionEvents, 
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error); 
              return snapshot.hasData ? EventPageState(items: snapshot.data): 
              
              // return the ListView widget : 
              Center(child: CircularProgressIndicator());
            },

      );
  }*/


}
