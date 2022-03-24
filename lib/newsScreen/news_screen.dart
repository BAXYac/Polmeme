import 'package:flutter/material.dart';

import 'package:polmeme/memeScreen/meme_screen.dart';
import 'package:polmeme/newsScreen/one_news_screen.dart';

class ListOfNews extends StatefulWidget {
  ListOfNews({Key? key}) : super(key: key);

  @override
  State<ListOfNews> createState() => _ListOfNewsState();
}

class _ListOfNewsState extends State<ListOfNews> {
  bool _clicked = true;
  void onPageChanged(int page) {
    setState(() {
      if (page == 0) {
        _clicked = true;
      } else {
        _clicked = false;
      }
    });
  }

  List list_of_news = [OneNews(), OneNews(), OneNews()];
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                onPageChanged: onPageChanged,
                controller: controller,
                children: [
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return myCard(index);
                    },
                    itemCount: list_of_news.length,
                  ),
                  const MemeScreen()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget myCard(index) {
    return Dismissible(
        key: UniqueKey(),
        onDismissed: (kierunkowy) {
          if (kierunkowy == DismissDirection.startToEnd ||
              kierunkowy == DismissDirection.endToStart) {
            list_of_news.removeAt(index);
          }
        },
        child: OneNews());
  }
}
