import 'package:flashcard/edit/card_list_presenter.dart';
import 'package:flashcard/edit/edit_noun_presenter.dart';
import 'package:flashcard/edit/edit_verb_presenter.dart';
import 'package:flashcard/model/noun.dart';
import 'package:flashcard/model/verb.dart';
import 'package:get_it/get_it.dart';

void setup() {
  GetIt.I.registerFactory(() => CardListPresenter());

  GetIt.I.registerFactoryParam<EditNounPresenter, Noun, void>(
      (noun, _) => EditNounPresenter(noun));

  GetIt.I.registerFactoryParam<EditVerbPresenter, Verb, void>(
      (verb, _) => EditVerbPresenter(verb: verb));
}
