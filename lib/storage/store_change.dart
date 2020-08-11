import 'dart:collection';

class StoreChange {
  final Map<String, dynamic> retainedFields;
  final Set<String> deletedFields;

  final Map<String, StoreChange> subcollections;
  final bool deleted;

  StoreChange(this.retainedFields, this.deletedFields, this.subcollections,
      this.deleted);
}

class StoreChangeBuilder {
  Map<String, dynamic> _retainedFields = HashMap();
  Set<String> _deletedFields = HashSet();

  Map<String, StoreChangeBuilder> _subcollections = HashMap();
  bool deleted = false;

  StoreChangeBuilder();

  StoreChangeBuilder deleteField(String field) {
    _deletedFields.add(field);
    return this;
  }

  StoreChangeBuilder setField(String field, dynamic value) {
    _retainedFields[field] = value;
    return this;
  }

  StoreChangeBuilder subcollection(String name) {
    StoreChangeBuilder subCollectionBuilder = StoreChangeBuilder();
    _subcollections[name] = subCollectionBuilder;
    return subCollectionBuilder;
  }

  StoreChange build() {
    Map<String, StoreChange> subcollections = _subcollections.map((key, value) {
      StoreChange change = value.build();
      return MapEntry(key, change);
    });

    return StoreChange(
        _retainedFields, _deletedFields, subcollections, deleted);
  }
}
