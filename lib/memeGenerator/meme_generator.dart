import 'package:flutter/material.dart';
import 'package:polmeme/provider/meme_gen_provider.dart';
import 'package:provider/provider.dart';

class MemeGen extends StatefulWidget {
  const MemeGen({Key? key}) : super(key: key);

  @override
  State<MemeGen> createState() => _MemeGenState();
}

class _MemeGenState extends State<MemeGen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    int _index = Provider.of<MemeGenProvider>(
      context,
    ).indexOfTemp;
    return Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.black,
        body: Center(
            child: ListView(
          shrinkWrap: true,
          children: [
            _index < 0
                ? SizedBox(
                    height: 150,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return item(context, index);
                        }),
                  )
                : item(context, -1),
            ..._listOfText,
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _listOfText.add(_input(index));
                  index = index + 1;
                });
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('+dadaj tekst'),
              ),
              style: ElevatedButton.styleFrom(primary: Color(0xff1B6569)),
            )
          ],
        )));
  }

  Widget item(context, index) {
    return Container(
      width: 250,
      height: 250,
      child: InkWell(
          onTap: () {
            Provider.of<MemeGenProvider>(context, listen: false).indexOfTemp =
                index;
          },
          child: FlutterLogo()),
    );
  }

  List<Widget> _listOfText = [];

  Widget _input(_index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white,
        child: TextFormField(
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.text_fields,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                onPressed: () {
                  setState(() {
                    _listOfText.removeAt(_index);
                    index = index - 1;
                  });
                },
              )),
        ),
      ),
    );
  }
}
