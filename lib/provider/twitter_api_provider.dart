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
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }

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
            "(from:OnetWiadomosci OR from:NewsweekPolska OR from:CzarnekP OR from:szymon_holownia OR from:JkmMikke OR from:AM_Zukowska OR from:tvp_info OR from:tvn24 OR from:Piechocinski OR from:GrzegorzBraun_ OR from:AndrzejDuda OR from:SylwiaSpurek OR from:MorawieckiM) -filter:retweets",
        'count': '40',
        'include_entities': 'true',
        'include_rts': 'false',
        'lang': 'pl',
        'tweet_mode': 'extended',
        'result_type': 'recent'
      }));

      Map<String, dynamic> data =
          Map<String, dynamic>.from(json.decode(response.body));

      _listOfTweets = data["statuses"];
      test = _listOfTweets[0]["user"]["url"];
    } catch (error) {
      print('error while requesting home timeline: $error');
    }

    notifyListeners();
  }
}
