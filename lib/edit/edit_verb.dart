import 'package:flashcard/edit/edit_verb_presenter.dart';
import 'package:flashcard/model/verb.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class EditVerbWidget extends StatefulWidget {
  final EditVerbPresenter _presenter;

  EditVerbWidget({Verb verb, EditVerbPresenter presenter})
      : _presenter = presenter ?? GetIt.I.get(param1: verb);
  @override
  State<StatefulWidget> createState() => _EditVerbState(_presenter);
}

class _EditVerbState extends State {
  final EditVerbPresenter _presenter;

  TextEditingController _wordController;
  TextEditingController _translationController;

  _EditVerbState(this._presenter) {
    _wordController = TextEditingController.fromValue(
        TextEditingValue(text: _presenter.word));
    _translationController = TextEditingController.fromValue(
        TextEditingValue(text: _presenter.translation));
    _wordController.addListener(() {
      _presenter.word = _wordController.text;
    });
    _translationController.addListener(() {
      _presenter.translation = _translationController.text;
    });
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
            _EditVerbForm(_presenter),
            SizedBox(
              width: 1,
              height: 15,
            ),
            FlatButton(
                onPressed: () async {
                  await _presenter.update();
                  Navigator.pop(context, "successful");
                },
                child: Text("Update"))
          ],
        ),
      ),
    );
  }
}

class _EditVerbForm extends StatelessWidget {
  final EditVerbPresenter _presenter;
  final Map<VerbFormType, TextEditingController> _controllers = Map();

  _EditVerbForm(this._presenter) {
    for (VerbFormType form in VerbFormType.values) {
      var controller = TextEditingController.fromValue(
          TextEditingValue(text: _presenter.form(form).verb));
      controller.addListener(() => _presenter.setForm(form, controller.text));

      _controllers[form] = controller;
    }
  }

  @override
  Widget build(BuildContext context) {
    var rows = VerbFormType.values
        .map((formType) => TableRow(
              children: [
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      _formName(formType),
                      style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
                TextField(
                  controller: _controllers[formType],
                  decoration: InputDecoration(
                    labelText: "Verb",
                  ),
                ),
              ],
            ))
        .toList();

    return Table(
      children: rows,
    );
  }

  String _formName(VerbFormType type) {
    switch (type) {
      case VerbFormType.ich:
        return "ich";
      case VerbFormType.du:
        return "du";
      case VerbFormType.er:
        return "er/sie/es";
      case VerbFormType.ihr:
        return "ihr";
      case VerbFormType.sie:
        return "sie";
      case VerbFormType.wir:
        return "wir";
      default:
        return "unknown";
    }
  }
}
