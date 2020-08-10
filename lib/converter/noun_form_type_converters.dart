import 'package:flashcard/model/noun.dart';

class NounFormTypeToStringConverter {
  String convert(NounFormType formType) {
    switch (formType) {
      case NounFormType.nominative:
        return "nominative";
      case NounFormType.accusative:
        return "accusative";
      default:
        return null;
    }
  }
}

class StringToNounFormTypeConverter {
  NounFormType convert(String s) {
    switch (s) {
      case "nominative":
        return NounFormType.nominative;
      case "accusative":
        return NounFormType.accusative;
      default:
        return null;
    }
  }
}
