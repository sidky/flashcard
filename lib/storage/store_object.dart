import 'package:flutter/material.dart';

class StoreObject {
  final Map<String, dynamic> fields;
  final Map<String, List<StoreObject>> subcollections;

  StoreObject(
      {@required Map<String, dynamic> fields,
      @required Map<String, List<StoreObject>> subcollections})
      : this.fields = fields,
        this.subcollections = subcollections;
}
