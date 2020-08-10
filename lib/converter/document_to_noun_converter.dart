import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcard/converter/document_to_noun_form_converter.dart';
import 'package:flashcard/model/noun.dart';
import 'dart:convert';
import 'dart:developer' as developer;

import 'package:get_it/get_it.dart';

class DocumentToNounConverter {
  final DocumentToNounFormConverter _converter;

  DocumentToNounConverter({DocumentToNounFormConverter converter})
      : _converter = converter ?? GetIt.I.get();

  Future<Noun> convert(DocumentSnapshot snapshot) async {
    final String word = snapshot.data["word"];
    final String translation = snapshot.data["translation"];
    final DateTime createdAt = snapshot.data["createdAt"];
    final DateTime updatedAt = snapshot.data["updatedAt"];

    //developer.log("forms", error: jsonEncode(snapshot));
    print(snapshot.data.keys);
    print(snapshot.data.values);

    var forms = await snapshot.reference.collection("forms").getDocuments();
    var converted = forms.documents.map((e) => _converter.convert(e)).toList();

    print(converted);

    var noun = Noun(snapshot.documentID, word, translation, converted,
        createdAt, updatedAt);

    print(noun.toJson());

    return noun;
  }
}
