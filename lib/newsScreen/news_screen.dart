import 'package:flutter/material.dart';
import 'package:polmeme/newsScreen/widgets/one_news_screen.dart';
import 'package:provider/provider.dart';
import '../provider/twitter_api_provider.dart';

class ListOfNews extends StatelessWidget {
  ListOfNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              profileUrl:
                  "https://twitter.com/${myProvider["user"]["screen_name"]}",
              currentIndex: myProvider,
              tweetUrl:
                  "https://twitter.com/${myProvider["user"]["screen_name"]}/status/${myProvider["id"]}",
              screenName: myProvider["user"]["screen_name"],
              userName: myProvider["user"]["name"],
              tweetTxt: myProvider["full_text"]));
    }

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
}
