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
    print("Converting noun");
    final String word = snapshot.data["word"];
    print("Word: $word");
    final String translation = snapshot.data["translation"];

    //developer.log("forms", error: jsonEncode(snapshot));
    print(snapshot.data.keys);
    print(snapshot.data.values);

    print("Converting: $word");
    var forms = await snapshot.reference.collection("forms").getDocuments();
    var converted = forms.documents.map((e) => _converter.convert(e)).toList();

    print(converted);

    var noun = Noun(snapshot.documentID, word, translation, converted);

    print(noun.toJson());

    return noun;
  }
}
