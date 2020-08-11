import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcard/storage/store_object.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'dart:convert';

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
      print("NOun Documents: ${event.documents.length}");
      var objects = event.documents.map((e) => convertDocument(e));
      print("Objects: ${objects.length}");

      return Future.wait(objects);
    });
  }

  Future<void> addObject(T object) async {
    print("Adding object");
    await _firestore.runTransaction((transaction) => _addObject(
        _firestore.collection(this.collectionName), convertObject(object)));
    print("Added object");
  }

  Future<void> updateObject(String id, T object) async {
    await _firestore.runTransaction((transaction) => _updateObject(
        _firestore.collection(this.collectionName).document(id),
        convertObject(object)));
  }

  Future<void> _addObject(
      CollectionReference reference, StoreObject object) async {
    print("Adding _object: ${object.toJson()}");
    var doc = await reference.add(object.fields);
    print("Adding _object: $doc");

    if (object.subcollections != null) {
      print(object.subcollections);
      object.subcollections.entries.forEach((e) async {
        CollectionReference reference = doc.collection(e.key);

        print("Subcollection: ${e.key}");

        e.value.forEach((element) async {
          print("Adding Value: $element");
          await _addObject(reference, element);
          print("Added Value: $element");
        });
      });
    }
  }

  Future<void> _updateObject(
      DocumentReference reference, StoreObject object) async {
    print("Setting object: ${object.toJson()}");
    await reference.setData(object.fields);

    print("Data set");

    if (object.subcollections == null) {
      return;
    }

    object.subcollections.entries.forEach((e) async {
      print("Setting subcollection");
      CollectionReference subcollection = reference.collection(e.key);

      e.value.forEach((item) async {
        if (item.id == null) {
          return _addObject(subcollection, item);
        } else {
          return _updateObject(subcollection.document(item.id), item);
        }
      });
    });
  }

  @protected
  Future<T> convertDocument(DocumentSnapshot snapshot);

  @protected
  StoreObject convertObject(T object);
}
