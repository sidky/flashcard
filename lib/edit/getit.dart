import 'package:flashcard/edit/card_list_presenter.dart';
import 'package:flashcard/edit/edit_noun_presenter.dart';
import 'package:flashcard/model/noun.dart';
import 'package:get_it/get_it.dart';

void setup() {
  GetIt.I.registerFactory(() => CardListPresenter());

  GetIt.I.registerFactoryParam<EditNounPresenter, Noun, void>(
      (noun, _) => EditNounPresenter(noun));
}
