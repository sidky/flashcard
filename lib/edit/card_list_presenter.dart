import 'package:flashcard/model/noun.dart';
import 'package:flashcard/repository/noun_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class CardList {
  final List<Noun> nouns;

  CardList({@required this.nouns});
}

class CardListPresenter {
  final NounRepository _nounRepository;

  CardListPresenter({NounRepository nounRepository})
      : _nounRepository = nounRepository ?? GetIt.I.get() {}

  Stream<List<Noun>> get nouns => _nounRepository.stream();

  Stream<CardList> get cardListStream =>
      CombineLatestStream.list([_nounRepository.stream()]).map((event) {
        print("********** ${event[0]}  ${event}");
        return CardList(nouns: event[0]);
      });
}
