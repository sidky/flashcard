import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcard/converter/document_to_verb_converter.dart';
import 'package:flashcard/converter/verb_to_object_converter.dart';
import 'package:flashcard/model/verb.dart';
import 'package:flashcard/storage/cloud_store.dart';
import 'package:flashcard/storage/store_object.dart';
import 'package:get_it/get_it.dart';

class VerbRepository extends CloudStore<Verb> {
  final DocumentToVerbConverter _toVerb;
  final VerbToStoreObjectConverter _toStoreObject;

  VerbRepository(
      {Firestore firestore,
      DocumentToVerbConverter toVerb,
      VerbToStoreObjectConverter fromVerb})
      : _toVerb = toVerb ?? GetIt.I.get(),
        _toStoreObject = fromVerb ?? GetIt.I.get(),
        super("verbs", firestore: firestore);

  @override
  Future<Verb> convertDocument(DocumentSnapshot snapshot) =>
      _toVerb.convert(snapshot);

  @override
  StoreObject convertObject(Verb object) => _toStoreObject.convert(object);
}
