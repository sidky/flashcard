import 'package:flashcard/auth/auth_presenter.dart';
import 'package:get_it/get_it.dart';

void setup() {
  GetIt.I.registerLazySingleton(() => AuthPresenter());
}
