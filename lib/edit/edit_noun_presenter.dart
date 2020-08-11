import 'dart:collection';

import 'package:flashcard/model/noun.dart';
import 'package:flashcard/repository/noun_repository.dart';
import 'package:get_it/get_it.dart';

class NounFormKey {
  final NounFormType type;
  final GrammaticalNumber number;

  NounFormKey(this.type, this.number);

  @override
  bool operator ==(o) =>
      o is NounFormKey && o != null && type == o.type && number == o.number;

  @override
  int get hashCode {
    int result = (type != null) ? type.hashCode : 0;
    result = 31 * result + (number != null ? number.hashCode : 0);
    return result;
  }
}

class EditNounPresenter {
  String _id;
  String _word;
  String _translation;
  NounRepository _repository;

  final Map<NounFormKey, NounForm> _forms = HashMap();

  EditNounPresenter(Noun noun, {NounRepository repository})
      : _repository = repository ?? GetIt.I.get() {
    _id = noun?.id;
    _word = noun?.word;
    _translation = noun?.translation;

    for (NounForm form in noun.forms) {
      _forms.putIfAbsent(NounFormKey(form.type, form.number), () => form);
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

  NounForm form(NounFormType type, GrammaticalNumber number) =>
      _forms[NounFormKey(type, number)] ?? NounForm("", type, number, "", "");

  void setForm(NounFormType type, GrammaticalNumber number, String article,
      String word) {
    NounForm form = _forms[NounFormKey(type, number)];

    if (form != null) {
      _forms[NounFormKey(type, number)] =
          form.copy(article: article, word: word);
    } else {
      _forms[NounFormKey(type, number)] =
          NounForm(null, type, number, article, word);
    }
  }

  Future<void> update() async {
    if (!isNonEmpty(_word)) throw ("Word can not be empty");
    if (!isNonEmpty(_translation)) throw ("Translation can not be empty");

    for (var entry in _forms.entries) {
      if (!isNonEmpty(entry.value.article) && !isNonEmpty(entry.value.word))
        continue;
      if (!isNonEmpty(entry.value.article))
        throw ("${_pairName(entry.key)} article is empty");
      if (!isNonEmpty(entry.value.word))
        throw ("${_pairName(entry.key)} word is empty");
    }

    Noun updatedNoun = Noun(_id, word, translation, _nonEmptyPairs());

    print("Updating: ${updatedNoun} ${_id}");

    if (_id == null) {
      await _repository
          .addObject(updatedNoun)
          .then((value) => print("Completed"));
      print("Updated");
    } else {
      await _repository
          .updateObject(_id, updatedNoun)
          .then((value) => print("Completed update"));
    }
  }

  bool isNonEmpty(String s) => s != null && s.isNotEmpty;

  List<NounForm> _nonEmptyPairs() => _forms.entries
      .where((element) =>
          isNonEmpty(element.value.article) && isNonEmpty(element.value.word))
      .map((e) => e.value)
      .toList();

  String _pairName(NounFormKey key) {
    if (key.type == NounFormType.nominative &&
        key.number == GrammaticalNumber.singular) {
      return "nominative singular";
    } else if (key.type == NounFormType.nominative &&
        key.number == GrammaticalNumber.plural) {
      return "nominative plural";
    } else if (key.type == NounFormType.accusative &&
        key.number == GrammaticalNumber.singular) {
      return "accusative singular";
    } else if (key.type == NounFormType.accusative &&
        key.number == GrammaticalNumber.plural) {
      return "accusative plural";
    } else {
      return "unknown";
    }
  }
}
