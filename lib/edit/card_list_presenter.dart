import 'package:flashcard/model/noun.dart';
import 'package:flashcard/model/verb.dart';
import 'package:flashcard/repository/noun_repository.dart';
import 'package:flashcard/repository/verb_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class CardList {
  final List<Noun> nouns;
  final List<Verb> verbs;

  CardList({@required this.nouns, @required this.verbs});
}

class CardListPresenter {
  final NounRepository _nounRepository;
  final VerbRepository _verbRepository;

  CardListPresenter(
      {NounRepository nounRepository, VerbRepository verbRepository})
      : _nounRepository = nounRepository ?? GetIt.I.get(),
        _verbRepository = verbRepository ?? GetIt.I.get();

  Stream<List<Noun>> get nouns => _nounRepository.stream();

  Stream<CardList> get cardListStream {
    return CombineLatestStream.list(
        [_nounRepository.stream(), _verbRepository.stream()]).map((event) {
      return CardList(nouns: event[0], verbs: event[1]);
    });
  }
}
