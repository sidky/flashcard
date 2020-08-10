import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcard/model/noun.dart';

class DocumentToNounFormConverter {
  NounForm convert(DocumentSnapshot snapshot) {
    NounFormType formType = _toNounForm(snapshot.data["type"]);
    GrammaticalNumber grammaticalNumber =
        _toGrammaticalNumber(snapshot.data["number"]);
    String article = snapshot.data["article"];
    String word = snapshot.data["word"];

    return NounForm(
        snapshot.documentID, formType, grammaticalNumber, article, word);
  }

  NounFormType _toNounForm(String formType) {
    return formType == "nominative"
        ? NounFormType.nominative
        : NounFormType.accusative;
  }

  GrammaticalNumber _toGrammaticalNumber(String number) {
    return number == "singular"
        ? GrammaticalNumber.singular
        : GrammaticalNumber.plural;
  }
}
