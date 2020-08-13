import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcard/converter/document_to_verb_form_converter.dart';
import 'package:flashcard/model/verb.dart';
import 'package:get_it/get_it.dart';

class DocumentToVerbConverter {
  DocumentToVerbFormConverter _converter;

  DocumentToVerbConverter({DocumentToVerbFormConverter converter})
      : _converter = converter ?? GetIt.I.get();

  Future<Verb> convert(DocumentSnapshot snapshot) async {
    String word = snapshot.data["word"];
    String translation = snapshot.data["translation"];

    var forms = await snapshot.reference.collection("forms").getDocuments();
    var converted = forms.documents.map((e) => _converter.convert(e)).toList();
    var verb = Verb(
        id: snapshot.documentID,
        base: word,
        translation: translation,
        forms: converted);

    return verb;
  }
}
