import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashcard/repository/auth_repository.dart';
import 'package:flashcard/repository/noun_repository.dart';
import 'package:get_it/get_it.dart';

void setup() {
  GetIt getIt = GetIt.I;

  // Firebase
  getIt.registerSingleton(FirebaseAuth.instance);

  getIt.registerSingleton(AuthRepository());

  getIt.registerSingleton(NounRepository());
}
