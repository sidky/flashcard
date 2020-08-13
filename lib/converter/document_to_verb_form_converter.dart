import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcard/converter/noun_form_type_converters.dart';
import 'package:flashcard/converter/verb_form_type_converters.dart';
import 'package:flashcard/model/verb.dart';
import 'package:get_it/get_it.dart';

class DocumentToVerbFormConverter {
  StringToVerbFormTypeConverter _converter;

  DocumentToVerbFormConverter({StringToVerbFormTypeConverter converter})
      : _converter = converter ?? GetIt.I.get();

  VerbForm convert(DocumentSnapshot snapshot) {
    VerbFormType type = _converter.convert(snapshot.data["type"]);
    String verb = snapshot.data["verb"];

    return VerbForm(type: type, verb: verb, id: snapshot.documentID);
  }
}
