import 'package:flashcard/model/word.dart';
import 'package:flutter/material.dart';

class WordCardWidget extends StatelessWidget {
  final Word word;

  const WordCardWidget({Key key, @required this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: 200,
        height: 100,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                word.word,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 1,
                height: 10,
              ),
              Text(
                word.translation,
                style: TextStyle(
                    fontStyle: FontStyle.italic, fontWeight: FontWeight.normal),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EmptyWordCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: 200,
        height: 100,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "+",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
