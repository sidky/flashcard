import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcard/converter/document_to_noun_converter.dart';
import 'package:flashcard/converter/noun_to_object_converter.dart';
import 'package:flashcard/model/noun.dart';
import 'package:flashcard/storage/cloud_store.dart';
import 'package:flashcard/storage/store_object.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class NounRepository extends CloudStore<Noun> {
  final DocumentToNounConverter _converter;
  final NounToStoreObjectConverter _nounConverter;

  NounRepository(
      {Firestore firestore,
      DocumentToNounConverter converter,
      NounToStoreObjectConverter nounConverter})
      : _converter = converter ?? GetIt.I.get(),
        _nounConverter = nounConverter ?? GetIt.I.get(),
        super("nouns", firestore: firestore);

  @override
  @protected
  Future<Noun> convertDocument(DocumentSnapshot snapshot) {
    return _converter.convert(snapshot);
  }

  @override
  StoreObject convertObject(Noun object) => _nounConverter.convert(object);
}
