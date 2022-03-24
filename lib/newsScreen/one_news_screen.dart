import 'package:flutter/material.dart';
import 'package:polmeme/provider/twitter_api_provider.dart';
import 'package:provider/provider.dart';
import 'package:dart_twitter_api/twitter_api.dart';

class OneNews extends StatefulWidget {
  OneNews({Key? key}) : super(key: key);

  @override
  State<OneNews> createState() => _OneNewsState();
}

class _OneNewsState extends State<OneNews> {
  final twitterApi = TwitterApi(
    client: TwitterClient(
      consumerKey: 'y0ouZhxHcZryqL69Ud4uJ3Ris',
      consumerSecret: 'DHbBGWP7Y4OnUN9UO9zqkQBb3jVEveRy6xTP5w4KpDFWkMFBCz',
      token: '1505509772501602309-RyJKe26WA3HYQRMIQnFVLPvW2gBBfK',
      secret: 'qYq9k8wkWThMUyi6TE7iGGJ5cZHMD9SB4TIhGNvFk977H',
    ),
  );
  @override
  Future<void> getTweet() async {
    final homeTimeline = await twitterApi.timelineService.homeTimeline(
      count: 10,
    );
    print(homeTimeline);
    try {
      // Get the last 200 tweets from your home timeline
      final homeTimeline = await twitterApi.timelineService.homeTimeline(
        count: 10,
      );
      print(homeTimeline[0]);
      // Print the text of each Tweet
      homeTimeline.forEach((tweet) => print(tweet.fullText));
    } catch (error) {
      print('error while requesting home timeline: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Color.fromARGB(255, 142, 179, 166),
          child: Column(
            children: [
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(Icons.photo),
                  ),
                  Text("Profile Name")
                ],
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      getTweet;
                    });
                  },
                  child: Text(
                    "cokolwiek",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: const Color(0xff1B6569),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                ),
                height: MediaQuery.of(context).size.height * 0.05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () {
                          Provider.of<TwietterApiProvider>(context,
                              listen: false);
                        },
                        child: const Text(
                          "Pokaż meme",
                          style: TextStyle(color: Colors.white),
                        )),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Stwórz meme",
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
