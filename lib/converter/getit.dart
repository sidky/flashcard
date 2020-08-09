import 'package:flashcard/converter/firebase_user_converter.dart';
import 'package:get_it/get_it.dart';

void setup() {
  GetIt.I.registerLazySingleton<FirebaseUserConverter>(
      () => FirebaseUserConverter());
}
