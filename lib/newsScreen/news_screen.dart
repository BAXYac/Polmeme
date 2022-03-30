import 'package:flutter/material.dart';
import 'package:polmeme/newsScreen/one_news_screen.dart';
import 'package:provider/provider.dart';
import '../provider/twitter_api_provider.dart';

class ListOfNews extends StatefulWidget {
  ListOfNews({Key? key}) : super(key: key);

  @override
  State<ListOfNews> createState() => _ListOfNewsState();
}

class _ListOfNewsState extends State<ListOfNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: FutureBuilder(
          future: Provider.of<TwietterApiProvider>(context, listen: false)
              .getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                          child:
                              //  Text(
                              //     Provider.of<TwietterApiProvider>(context).test.toString())

                              // dlugosc listy < 1 ? Circular progress indicator:

                              ListView.builder(
                            itemBuilder: (context, index) {
                              return myCard(index);
                            },
                            itemCount: Provider.of<TwietterApiProvider>(context,
                                    listen: false)
                                .listOfTweets
                                .length,
                          ),
                        ),
                      ],
                    ),
                  );
                }
            }

            // By default, show a loading spinner.
          },
        ));
  }

  Widget myCard(index) {
    var myProvider = Provider.of<TwietterApiProvider>(context, listen: false)
        .listOfTweets[index];
    return Dismissible(
        key: UniqueKey(),
        onDismissed: (kierunkowy) {
          if (kierunkowy == DismissDirection.startToEnd ||
              kierunkowy == DismissDirection.endToStart) {
            Provider.of<TwietterApiProvider>(context, listen: false)
                .listOfTweets
                .removeAt(index);
          }
        },
        child: OneNews(
            currentIndex: myProvider,
            tweetUrl:
                "https://twitter.com/${myProvider["user"]["screen_name"]}/status/${myProvider["id"]}",
            screenName: myProvider["user"]["screen_name"],
            userName: myProvider["user"]["name"],
            tweetTxt: myProvider["full_text"]));
  }
}
