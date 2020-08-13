import 'package:flashcard/model/verb.dart';

class VerbFormTypeToStringConverter {
  String convert(VerbFormType type) {
    switch (type) {
      case VerbFormType.ich:
        return "ich";
      case VerbFormType.du:
        return "du";
      case VerbFormType.er:
        return "er";
      case VerbFormType.wir:
        return "wir";
      case VerbFormType.ihr:
        return "ihr";
      case VerbFormType.sie:
        return "sie";
      default:
        return "unknown";
    }
  }
}

class StringToVerbFormTypeConverter {
  VerbFormType convert(String s) {
    switch (s) {
      case "ich":
        return VerbFormType.ich;
      case "du":
        return VerbFormType.du;
      case "er":
        return VerbFormType.er;
      case "wir":
        return VerbFormType.wir;
      case "ihr":
        return VerbFormType.ihr;
      case "sie":
        return VerbFormType.sie;
      default:
        return null;
    }
  }
}
