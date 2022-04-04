import 'package:flutter/material.dart';
import 'package:polmeme/auth/login_page.dart';
import 'package:polmeme/newsScreen/widgets/myAlertDialog.dart';
import 'package:polmeme/provider/twitter_api_provider.dart';
import 'package:provider/provider.dart';
import 'package:linkwell/linkwell.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../auth/auth_state.dart';

class OneNews extends StatelessWidget {
  OneNews({
    Key? key,
    required this.tweetTxt,
    required this.userName,
    required this.screenName,
    required this.tweetUrl,
    required this.currentIndex,
    required this.profileUrl,
  }) : super(key: key);
  final String tweetTxt;
  final String userName;
  final String screenName;
  final String tweetUrl;
  final dynamic currentIndex;
  final String profileUrl;

  @override
  Widget build(BuildContext context) {
    bool loggedIn =
        Provider.of<AuthState>(context, listen: false).auth.currentUser != null;
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: const Color.fromARGB(255, 142, 179, 166),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            decoration: const BoxDecoration(
              color: Color(0xff1B6569),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ClipOval(
                    child: FadeInImage.memoryNetwork(
                      width: 25,
                      image: currentIndex["user"]["profile_image_url"],
                      placeholder: kTransparentImage,
                    ),
                  ),
                ),
                TextButton(
                  child: Text(userName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  onPressed: () {
                    Provider.of<TwietterApiProvider>(context, listen: false)
                        .launchURL(profileUrl);
                  },
                ),
                Expanded(
                  child: Text(
                    "@$screenName",
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
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  LinkWell(
                    tweetTxt
                        .replaceAll("https:/", "\n")
                        .replaceAll("&gt;&gt;&gt;", ""),
                    linkStyle: const TextStyle(color: Colors.white),
                  ),

                  const SizedBox(
                    height: 8,
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
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: FadeInImage.memoryNetwork(
                            image: currentIndex["extended_entities"]["media"][0]
                                ["media_url_https"],
                            placeholder: kTransparentImage,
                          ),
                        ),
                ],
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xff1B6569),
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
                    onPressed: loggedIn
                        ? () {}
                        : () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) =>
                                    const MyAlertDialog());
                          },
                    child: Text(
                      "Stwórz meme",
                      style: TextStyle(
                          color: loggedIn ? Colors.white : Colors.grey),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
