import 'package:flutter/material.dart';
import 'package:polmeme/provider/twitter_api_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:linkwell/linkwell.dart';

class OneNews extends StatelessWidget {
  OneNews({
    Key? key,
    required this.tweetTxt,
    required this.userName,
    required this.screenName,
    required this.tweetUrl,
    required this.currentIndex,
  }) : super(key: key);
  final String tweetTxt;
  final String userName;
  final String screenName;
  final String tweetUrl;
  final dynamic currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Color.fromARGB(255, 142, 179, 166),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.03,
                color: Colors.white30,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: SvgPicture.asset("assets/icons8-twitter (1).svg",
                          color: Colors.blue),
                    ),
                    Text(userName,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Expanded(
                      child: Text(
                        " @" +
                            screenName +
                            "eeeeeeeeeeeeeeeeeerrrrrrrraaaaaaaaaa",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Provider.of<TwietterApiProvider>(context, listen: false)
                      .launchURL(tweetUrl);
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      LinkWell(
                        tweetTxt,
                        linkStyle: TextStyle(color: Colors.white),
                      ),
                      //  currentIndex["extended_entities"] != null
                      //     ? Container(
                      //         decoration: BoxDecoration(
                      //             color: Colors.black,
                      //             image: DecorationImage(
                      //                 image: NetworkImage(
                      //                      currentIndex["entities"]
                      //                         ["media"][0]["url"]),
                      //                 fit: BoxFit.cover)),
                      //       )
                      // :
                      currentIndex["extended_entities"] == null
                          ? Container()
                          : Container(
                              // height: MediaQuery.of(context).size.height * 0.15,
                              // width: 210,
                              // decoration: BoxDecoration(
                              //     color: Colors.black,
                              //     image: DecorationImage(
                              //         image: NetworkImage(
                              //             "https://images.pexels.com/photos/1629781/pexels-photo-1629781.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500"),
                              //         fit: BoxFit.cover)),
                              //
                              height: MediaQuery.of(context).size.height * 0.25,
                              width: 270,
                              decoration: BoxDecoration(
                                  color: Colors.pink,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          currentIndex["extended_entities"]
                                              ["media"][0]["media_url_https"]),
                                      fit: BoxFit.cover)),
                            )
                    ],
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
                        onPressed: () {},
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
