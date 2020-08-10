import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get_it/get_it.dart';

void setup() {
  GetIt.I.registerSingleton(Firestore.instance);
}
