import 'package:flashcard/edit/card_list_presenter.dart';
import 'package:get_it/get_it.dart';

void setup() {
  GetIt.I.registerLazySingleton(() => CardListPresenter());
}
