import 'package:flashcard/model/noun.dart';
import 'package:flutter/material.dart';

class EditNounWidget extends StatefulWidget {
  final Noun noun;

  EditNounWidget({this.noun});

  @override
  State<StatefulWidget> createState() => _EditNounState(noun: noun);
}

class _EditNounState extends State {
  Noun _noun;

  final TextEditingController _wordController;
  final TextEditingController _translationController;

  _EditNounState({Noun noun})
      : _noun = noun ?? Noun.empty(),
        _wordController = TextEditingController.fromValue(
            TextEditingValue(text: noun?.word ?? "")),
        _translationController = TextEditingController.fromValue(
            TextEditingValue(text: noun?.translation ?? ""));

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
          _EditNounForms(_noun, GrammaticalNumber.singular),
          Text("Plural"),
          _EditNounForms(_noun, GrammaticalNumber.plural),
        ],
      )),
    );
  }
}

class _EditNounForms extends StatelessWidget {
  final Noun _noun;
  final GrammaticalNumber _number;

  _EditNounForms(this._noun, this._number,
      {void onUpdated(GrammaticalNumber number, NounFormType type)});

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
    NounForm form = _findForm(type, _number);

    var articleController = TextEditingController.fromValue(
        TextEditingValue(text: form?.article ?? ""));
    var wordController = TextEditingController.fromValue(
        TextEditingValue(text: form?.word ?? ""));

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
            controller: articleController,
            decoration: InputDecoration(labelText: "article"),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(5),
          child: TextField(
            controller: wordController,
            decoration: InputDecoration(labelText: "word"),
          ),
        ),
      ],
    );
  }

  NounForm _findForm(NounFormType type, GrammaticalNumber number) => _noun.forms
      .firstWhere((element) => element.type == type && element.number == number,
          orElse: () => null);

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
