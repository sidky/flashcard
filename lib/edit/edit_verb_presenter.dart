import 'dart:collection';

import 'package:flashcard/model/verb.dart';
import 'package:flashcard/repository/verb_repository.dart';
import 'package:get_it/get_it.dart';

class EditVerbPresenter {
  VerbRepository _verbRepository;

  String _id;
  String _word;
  String _translation;

  final Map<VerbFormType, VerbForm> _forms = Map();

  EditVerbPresenter({Verb verb, VerbRepository repository})
      : _verbRepository = repository ?? GetIt.I.get() {
    _id = verb?.id;
    _word = verb?.word;
    _translation = verb?.translation;

    if (verb?.forms != null) {
      for (VerbForm form in verb?.forms) {
        _forms[form.type] = form;
      }
    }
  }

  String get word => _word ?? "";
  set word(String newWord) =>
      _word = (newWord != null && newWord.isEmpty) ? null : newWord;

  String get translation => _translation ?? "";
  set translation(String newTranslation) =>
      _translation = (newTranslation != null && newTranslation.isEmpty)
          ? null
          : newTranslation;

  VerbForm form(VerbFormType type) =>
      _forms[type] ?? VerbForm(type: type, verb: "");
  void setForm(VerbFormType type, String verb) {
    VerbForm oldForm = _forms[type];

    if (oldForm != null) {
      _forms[type] = oldForm.copy(verb: verb);
    } else {
      _forms[type] = VerbForm(type: type, verb: verb);
    }
  }

  Future<void> update() {
    if (!isNonEmpty(_word)) throw ("Word can not be empty");
    if (!isNonEmpty(_translation)) throw ("Translation can not be empty");

    Verb verb = Verb(
        id: _id,
        base: word,
        translation: translation,
        forms: _forms.values.toList());

    if (_id == null) {
      return _verbRepository.addObject(verb);
    } else {
      return _verbRepository.updateObject(_id, verb);
    }
  }

  bool isNonEmpty(String s) => s != null && s.isNotEmpty;

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
