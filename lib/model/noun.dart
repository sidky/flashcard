import 'package:flashcard/model/word.dart';
import 'dart:convert';

enum NounFormType { nominative, accusative }

enum GrammaticalNumber {
  singular,
  plural,
}

class NounForm {
  final String id;
  final NounFormType type;
  final GrammaticalNumber number;
  final String article;
  final String word;

  NounForm(this.id, this.type, this.number, this.article, this.word);

  Map<String, dynamic> toJson() =>
      {"type": type, "number": number, "article": article, "word": word};
}

class Noun extends Word {
  final List<NounForm> forms;

  Noun(String id, String base, String translation, this.forms,
      DateTime createdAt, DateTime updatedAt)
      : super(id, base, translation, createdAt, updatedAt);

  Noun.empty()
      : forms = List.empty(),
        super("", "", "", null, null);

  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        "forms": forms.map((e) => e.toJson()),
      };
}
