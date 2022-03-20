import 'package:flutter/material.dart';

class OneNews extends StatelessWidget {
  const OneNews({Key? key}) : super(key: key);

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
                  onTap: () {},
                  child: const Text(
                    "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable..There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable.",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 39, 116, 90),
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
