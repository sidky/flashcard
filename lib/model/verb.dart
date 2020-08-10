import 'package:flashcard/model/word.dart';

enum VerbFormType { ich, du, er, wir, ihr }

class VerbForm {
  VerbFormType type;
  String verb;

  VerbForm(this.type, this.verb);
}

class Verb extends Word {
  List<VerbForm> forms;

  Verb(String id, String base, String translation, this.forms,
      DateTime createdAt, DateTime updatedAt)
      : super(id, base, translation, createdAt, updatedAt);
}
