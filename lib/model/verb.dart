import 'package:flashcard/model/word.dart';
import 'package:flutter/material.dart';

enum VerbFormType { ich, du, er, wir, ihr, sie }

class VerbForm {
  String id;
  VerbFormType type;
  String verb;

  VerbForm({@required this.type, @required this.verb, this.id});

  VerbForm copy({String id, String type, String verb}) => VerbForm(
      id: id ?? this.id, type: type ?? this.type, verb: verb ?? this.verb);
}

class Verb extends Word {
  List<VerbForm> forms;

  Verb(
      {String id,
      @required String base,
      @required String translation,
      @required this.forms})
      : super(id, base, translation);

  Verb copy(
          {String id,
          @required String base,
          @required String translation,
          @required List<VerbFormType> forms}) =>
      Verb(
          id: id ?? this.id,
          base: base ?? this.word,
          translation: translation ?? this.translation,
          forms: forms ?? this.forms);
}
