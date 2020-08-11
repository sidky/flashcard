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
    print("***** Create stream");
    return this
        ._firestore
        .collection(this.collectionName)
        .snapshots()
        .asyncMap((event) async {
      print("Documents: ${event.documents.length}");
      var objects = event.documents.map((e) => convertDocument(e));
      print("Objects: ${objects.length}");

      return Future.wait(objects);
    }).handleError((e) {
      print("Error: $e");
    });
  }

  Future<void> addObject(T object) async =>
      _firestore.runTransaction((transaction) => _addObject(
          _firestore.collection(this.collectionName), convertObject(object)));

  Future<void> updateObject(String id, T object) async =>
      _firestore.runTransaction((transaction) => _setObject(
          _firestore.collection(this.collectionName).document(id),
          convertObject(object)));

  Future<void> _addObject(
      CollectionReference reference, StoreObject object) async {
    print("Adding to: ${reference.toString()}");
    var doc = await reference.add(object.fields);

    return await Future.wait(object.subcollections.entries.map((e) {
      CollectionReference reference = doc.collection(e.key);
      return Future.wait(e.value.map((item) => _addObject(reference, item)));
    }));
  }

  Future<void> _setObject(
      DocumentReference reference, StoreObject object) async {
    print("Adding to: ${reference.toString()}");
    await reference.setData(object.fields);

    return await Future.wait(object.subcollections.entries.map((e) {
      CollectionReference subcollection = reference.collection(e.key);
      return Future.wait(
          e.value.map((item) => _addObject(subcollection, item)));
    }));
  }

  @protected
  Future<T> convertDocument(DocumentSnapshot snapshot);

  @protected
  StoreObject convertObject(T object);
}
