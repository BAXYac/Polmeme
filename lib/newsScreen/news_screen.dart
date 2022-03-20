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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: const [
            Text(
              "Polmem",
              style: TextStyle(
                color: Color.fromARGB(255, 39, 116, 90),
              ),
            ),
            Icon(
              Icons.memory,
              color: Color.fromARGB(255, 39, 116, 90),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                    color: _clicked == true
                        ? Color.fromARGB(255, 39, 116, 90)
                        : Colors.black,
                  ),
                  width: 185,
                  child: TextButton(
                      child: const Text(
                        "NEWS",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          _clicked = true;
                        });
                        controller.animateToPage(0,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeIn);
                      }),
                ),
                Container(
                  height: 40,
                  width: 185,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    color: _clicked == true
                        ? Colors.black
                        : Color.fromARGB(255, 13, 128, 89),
                  ),
                  child: TextButton(
                      child: const Text(
                        "MEME",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          _clicked = false;
                        });
                        controller.animateToPage(1,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeIn);
                      }),
                ),
              ],
            ),
          ),
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
