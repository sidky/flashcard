import 'dart:collection';

import 'package:flashcard/edit/edit_noun_presenter.dart';
import 'package:flashcard/model/noun.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class EditNounWidget extends StatefulWidget {
  final Noun noun;

  EditNounWidget({this.noun});

  @override
  State<StatefulWidget> createState() => _EditNounState(noun: noun);
}

class _EditNounState extends State {
  final TextEditingController _wordController;
  final TextEditingController _translationController;

  final EditNounPresenter _presenter;

  _EditNounState({Noun noun, EditNounPresenter presenter})
      : _presenter = presenter ?? GetIt.I.get(param1: noun),
        _wordController = TextEditingController(),
        _translationController = TextEditingController() {
    _wordController.text = _presenter.word;
    _translationController.text = _presenter.translation;

    _wordController.addListener(() => _presenter.word = _wordController.text);
    _translationController.addListener(
        () => _presenter.translation = _translationController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: _wordController,
              decoration: InputDecoration(labelText: "Word"),
            ),
            TextField(
              controller: _translationController,
              decoration: InputDecoration(labelText: "Translation"),
            ),
            Text("Singular"),
            _EditNounForms(GrammaticalNumber.singular, _presenter),
            Text("Plural"),
            _EditNounForms(GrammaticalNumber.plural, _presenter),
            SizedBox(width: 1, height: 20),
            Row(
              children: [
                FlatButton(
                  onPressed: () async {
                    await _presenter.update();
                    Navigator.pop(context, "Saved");
                  },
                  padding: EdgeInsets.all(25),
                  child: Text(
                    "Save changes",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                ),
                FlatButton(
                  onPressed: () async {
                    Navigator.pop(context, "Cancelled");
                  },
                  padding: EdgeInsets.all(25),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EditNounForms extends StatelessWidget {
  final EditNounPresenter _presenter;
  final GrammaticalNumber _number;

  final HashMap<NounFormType, _NounFormUIControllers> _controllers =
      HashMap.from({
    NounFormType.accusative: _NounFormUIControllers.instantiate(),
    NounFormType.nominative: _NounFormUIControllers.instantiate(),
  });

  _EditNounForms(this._number, this._presenter) {
    _controllers[NounFormType.nominative].article.text =
        _presenter.form(NounFormType.nominative, _number).article;
    _controllers[NounFormType.nominative].word.text =
        _presenter.form(NounFormType.nominative, _number).word;

    _controllers[NounFormType.accusative].article.text =
        _presenter.form(NounFormType.accusative, _number).article;
    _controllers[NounFormType.accusative].word.text =
        _presenter.form(NounFormType.accusative, _number).word;

    _controllers[NounFormType.nominative].addListener(() {
      String article = _controllers[NounFormType.nominative].article.text;
      String word = _controllers[NounFormType.nominative].word.text;

      _presenter.setForm(NounFormType.nominative, _number, article, word);
    });

    _controllers[NounFormType.accusative].addListener(() {
      String article = _controllers[NounFormType.accusative].article.text;
      String word = _controllers[NounFormType.accusative].word.text;

      _presenter.setForm(NounFormType.accusative, _number, article, word);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      children: [
        _nounCaseRow(NounFormType.nominative),
        _nounCaseRow(NounFormType.accusative),
      ],
    );
  }

  TableRow _nounCaseRow(NounFormType type) {
    return TableRow(
      children: [
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Text(
            _nounCaseName(type),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(5),
          child: TextField(
            controller: _controllers[type].article,
            decoration: InputDecoration(labelText: "article"),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(5),
          child: TextField(
            controller: _controllers[type].word,
            decoration: InputDecoration(labelText: "word"),
          ),
        ),
      ],
    );
  }

  String _nounCaseName(NounFormType type) {
    switch (type) {
      case NounFormType.accusative:
        return "Accusative";
      case NounFormType.nominative:
        return "Nominative";
      default:
        return "Unknown";
    }
  }
}

class _NounFormUIControllers {
  final TextEditingController article;
  final TextEditingController word;

  _NounFormUIControllers({@required this.article, @required this.word});

  _NounFormUIControllers.instantiate()
      : this(article: TextEditingController(), word: TextEditingController());

  void addListener(void onUpdated()) {
    article.addListener(onUpdated);
    word.addListener(onUpdated);
  }

  void dispose() {
    article.dispose();
    word.dispose();
  }
}
