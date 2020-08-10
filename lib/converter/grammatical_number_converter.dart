import 'package:flashcard/model/noun.dart';

class GrammaticalNumberToStringConverter {
  String convert(GrammaticalNumber number) {
    switch (number) {
      case GrammaticalNumber.singular:
        return "singular";
      case GrammaticalNumber.plural:
        return "plural";
      default:
        return null;
    }
  }
}

class StringToGrammaticalNumberConverter {
  GrammaticalNumber convert(String s) {
    switch (s) {
      case "singular":
        return GrammaticalNumber.singular;
      case "plural":
        return GrammaticalNumber.plural;
      default:
        return null;
    }
  }
}
