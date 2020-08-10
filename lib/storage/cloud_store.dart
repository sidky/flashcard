import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcard/storage/store_object.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

abstract class CloudStore<T> {
  final Firestore _firestore;
  final String collectionName;

  CloudStore(this.collectionName, {Firestore firestore})
      : this._firestore = firestore ?? GetIt.I.get();

  Stream<List<T>> stream() {
    return this
        ._firestore
        .collection(this.collectionName)
        .snapshots()
        .asyncMap((event) async {
      var objects = event.documents.map((e) => convertDocument(e));

      return Future.wait(objects);
    });
  }

  Future<void> addObject(T object) async =>
      _firestore.runTransaction((transaction) => _addObject(
          _firestore.collection(this.collectionName), convertObject(object)));

  Future<void> _addObject(
      CollectionReference reference, StoreObject object) async {
    var doc = await reference.add(object.fields);

    return await Future.wait(object.subcollections.entries.map((e) {
      CollectionReference reference = doc.collection(e.key);
      return Future.wait(e.value.map((item) => _addObject(reference, item)));
    }));
  }

  @protected
  Future<T> convertDocument(DocumentSnapshot snapshot);

  @protected
  StoreObject convertObject(T object);
}
