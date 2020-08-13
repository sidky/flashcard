import 'package:flashcard/edit/card_list_presenter.dart';
import 'package:flashcard/edit/edit_noun.dart';
import 'package:flashcard/edit/edit_verb.dart';
import 'package:flashcard/edit/word_card.dart';
import 'package:flashcard/model/noun.dart';
import 'package:flashcard/model/verb.dart';
import 'package:flashcard/model/word.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'dart:core';

class CardListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CardListWidgetState();
}

class CardListWidgetState extends State {
  final CardListPresenter _presenter;

  CardListWidgetState({CardListPresenter presenter})
      : _presenter = presenter ?? GetIt.I.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<CardList>(
        stream: _presenter.cardListStream,
        builder: (BuildContext context, AsyncSnapshot<CardList> snapshot) {
          double width = MediaQuery.of(context).size.width;

          var data = snapshot.data;

          if (data == null) {
            return Text("No words");
          }
          int columns = (width / 200).floor();
          if (columns == 0) {
            columns = 1;
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                _buildWordTile(
                    "Noun",
                    data.nouns,
                    (Noun noun) async => await _editWord(
                        context, (context) => EditNounWidget(noun: noun))),
                _buildWordTile(
                    "Verb",
                    data.verbs,
                    (Verb verb) async => await _editWord(
                        context,
                        (context) => EditVerbWidget(
                              verb: verb,
                            )))
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildWordTile<T extends Word>(
      String title, List<T> words, void editWord(T word)) {
    return ExpansionTile(
      title: Text(title),
      children: [
        GridView.builder(
            itemCount: words.length + 1,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200),
            itemBuilder: (BuildContext context, int index) {
              if (index < words.length) {
                return GestureDetector(
                    onTap: () => editWord(words[index]),
                    child: WordCardWidget(word: words[index]));
              } else {
                return GestureDetector(
                    onTap: () => editWord(null), child: EmptyWordCardWidget());
              }
            })
      ],
    );
  }

  Future<void> _editWord(
      BuildContext context, Widget builder(BuildContext context)) async {
    await Navigator.push(context, MaterialPageRoute(builder: builder));
    setState(() {});
  }
}
