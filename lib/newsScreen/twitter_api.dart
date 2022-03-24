import 'dart:convert';
import 'package:dart_twitter_api/twitter_api.dart';
import 'package:http/http.dart';

final twitterApi = TwitterApi(
  client: TwitterClient(
    consumerKey: '8vwngwZhHGwVI0Vz8C7BZDX2P',
    consumerSecret: 'YNhAmf5BHO8TuJ3BdfjqePiRB1V6HCSzUsFZIFcJmNuLiz6BvM',
    token: '1379855274652106753-aPHlNlMPpuT29JDa4b4nbUWg0porPw',
    secret: 'PIuxfZu6yl14zYCoSgUp4q8PqtgW7hgaZ5xFcPk52kRYY',
  ),
);

Future Tweet() async {
  Response response = await twitterApi.client.get(Uri.https(
      'api.twitter.com',
      '1.1/statuses/home_timeline.json',
      <String, String>{'count': '5', 'tweet_mode': 'extended'}));
  var res = response.body;
  var lista = jsonDecode(res) as List<dynamic>;

  print(lista.toString());
}
// final search = await twitterApi.tweetSearchService.searchTweets(
//       q: 'morawiecki',
//       count: 1,
//       lang: 'pl',
//     );
//     print(search.runtimeType);