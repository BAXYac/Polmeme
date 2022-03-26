import 'dart:convert';
import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class TwietterApiProvider extends ChangeNotifier {
  TwitterApi? twitterApi;
  List<dynamic> _listOfTweets = [];
  List<dynamic> get listOfTweets => _listOfTweets;
  set listOfText(List<dynamic> newList) {
    _listOfTweets = newList;
    notifyListeners();
  }

  TwietterApiProvider() {
    _init();
  }

  _init() {
    twitterApi = TwitterApi(
      client: TwitterClient(
        consumerKey: '8vwngwZhHGwVI0Vz8C7BZDX2P',
        consumerSecret: 'YNhAmf5BHO8TuJ3BdfjqePiRB1V6HCSzUsFZIFcJmNuLiz6BvM',
        token: '1379855274652106753-aPHlNlMPpuT29JDa4b4nbUWg0porPw',
        secret: 'PIuxfZu6yl14zYCoSgUp4q8PqtgW7hgaZ5xFcPk52kRYY',
      ),
    );
    _getData();
  }

  Future<void> _getData() async {
    try {
      Response response = await twitterApi!.client.get(Uri.https(
          'api.twitter.com',
          '1.1/statuses/home_timeline.json', <String, String>{
        'count': '7',
        'tweet_mode': 'extended',
        'include_entities': 'false'
      }));
      var res = response.body;
      List<Map<String, dynamic>> data =
          List<Map<String, dynamic>>.from(json.decode(response.body));

      data.forEach((tweet) => _listOfTweets.add(tweet));
      print(_listOfTweets);

      notifyListeners();
    } catch (error) {
      print('error while requesting home timeline: $error');
    }
  }
}