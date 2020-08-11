import 'dart:collection';

import 'package:flutter/material.dart';

class StoreObject {
  final String id;
  final Map<String, dynamic> fields;
  final Map<String, List<StoreObject>> subcollections;

  StoreObject({this.id, @required this.fields, @required this.subcollections});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> s;
    if (subcollections != null) {
      s = subcollections
          .map((key, value) => MapEntry(key, value.map((e) => e.toJson())));
    } else {
      s = new HashMap();
    }

    return {
      ...fields,
      ...s,
    };
  }
}
