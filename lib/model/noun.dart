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

  NounForm copy(
      {String id,
      NounFormType type,
      GrammaticalNumber number,
      String article,
      String word}) {
    return NounForm(id ?? this.id, type ?? this.type, number ?? this.number,
        article ?? this.article, word ?? this.word);
  }
}

class Noun extends Word {
  final List<NounForm> forms;

  Noun(String id, String base, String translation, this.forms)
      : super(id, base, translation);

  Noun.empty()
      : forms = List.empty(),
        super("", "", "");

  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        "forms": forms.map((e) => e.toJson()),
      };
}
