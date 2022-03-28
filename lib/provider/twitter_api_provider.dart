import 'dart:convert';
import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

class TwietterApiProvider extends ChangeNotifier {
  TwitterApi? twitterApi;
  List<dynamic> _listOfTweets = [];
  List<dynamic> get listOfTweets => _listOfTweets;
  set listOfText(List<dynamic> newList) {
    _listOfTweets = newList;
    notifyListeners();
  }

  var test;

  launchURL(url) async {
    // for (var index in _listOfTweets) {
    //String url = _listOfTweets[index]["extended_entities"]["media"][0]["expanded_url"];
    if (await canLaunch(url)) {
      await launch(url);
      print(url);
    } else {
      throw 'Could not launch $url';
    }
    // }
    notifyListeners();
  }

  Future<void> getData() async {
    try {
      twitterApi = TwitterApi(
        client: TwitterClient(
          consumerKey: '8vwngwZhHGwVI0Vz8C7BZDX2P',
          consumerSecret: 'YNhAmf5BHO8TuJ3BdfjqePiRB1V6HCSzUsFZIFcJmNuLiz6BvM',
          token: '1379855274652106753-aPHlNlMPpuT29JDa4b4nbUWg0porPw',
          secret: 'PIuxfZu6yl14zYCoSgUp4q8PqtgW7hgaZ5xFcPk52kRYY',
        ),
      );
      Response response = await twitterApi!.client.get(Uri.https(
          'api.twitter.com', '1.1/search/tweets.json', <String, String>{
        'q':
            "from:tvp_info OR from:tvn24 OR from:Piechocinski OR from:GrzegorzBraun_ OR from:AndrzejDuda",
        'count': '10',
        'include_entities': 'true',
        'include_rts': 'false',
        'lang': 'pl',
        'tweet_mode': 'extended',
        'result_type': 'mixed'
      }));

      // Response response = await twitterApi!.client.get(Uri.https(
      //     'api.twitter.com',
      //     '1.1/statuses/home_timeline.json', <String, String>{
      //   'count': '10',
      //   'tweet_mode': 'extended',
      //   'include_entities': 'true',
      //   'exclude_replies': 'true'
      // }));
      var res = response.body;
      // List<Map<String, dynamic>> data =
      //     List<Map<String, dynamic>>.from(json.decode(response.body));

      // data.forEach((tweet) => _listOfTweets.add(tweet));
      // test = _listOfTweets[0];
      // print(_listOfTweets);

      Map<String, dynamic> data =
          Map<String, dynamic>.from(json.decode(response.body));
      print(data["statuses"][0].keys);
      _listOfTweets = data["statuses"];
      test = _listOfTweets[0]["entities"];
    } catch (error) {
      print('error while requesting home timeline: $error');
    }

    notifyListeners();
  }
}
