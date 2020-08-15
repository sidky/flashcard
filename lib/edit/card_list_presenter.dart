import 'package:flashcard/model/noun.dart';
import 'package:flashcard/model/verb.dart';
import 'package:flashcard/model/word.dart';
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

class _CardFilter {
  final String text;

  _CardFilter({this.text});
}

extension _ApplyCardFilter on Word {
  bool select(_CardFilter f) =>
      (f != null && f.text != null && f.text.length > 0)
          ? this.word.toLowerCase().contains(f.text.toLowerCase())
          : true;
}

extension _ListFilter<T> on List<T> {
  List<T> filter(bool fn(T t)) {
    List<T> filtered = List();

    this.forEach((element) {
      if (fn(element)) {
        filtered.add(element);
      }
    });

    return filtered;
  }
}

class CardListPresenter {
  final NounRepository _nounRepository;
  final VerbRepository _verbRepository;
  final BehaviorSubject _filterSubject = BehaviorSubject();

  CardListPresenter(
      {NounRepository nounRepository, VerbRepository verbRepository})
      : _nounRepository = nounRepository ?? GetIt.I.get(),
        _verbRepository = verbRepository ?? GetIt.I.get() {
    _filterSubject.add(_CardFilter(text: ""));
  }

  Stream<List<Noun>> get nouns => CombineLatestStream<dynamic, List<Noun>>([
        _nounRepository.stream().map((s) => s.sortByWord()),
        _filterSubject.stream,
      ], (values) {
        List<Noun> l = values[0];
        _CardFilter f = values[1];
        return l.filter((t) => t.select(f));
      });

  Stream<List<Verb>> get verbs => CombineLatestStream<dynamic, List<Verb>>([
        _verbRepository.stream().map((s) => s.sortByWord()),
        _filterSubject.stream,
      ], (values) {
        List<Verb> v = values[0];
        _CardFilter f = values[1];
        return v.filter((t) => t.select(f));
      });

  Stream<CardList> get cardListStream {
    return CombineLatestStream.list([nouns, verbs]).map((event) {
      return CardList(nouns: event[0], verbs: event[1]);
    });
  }

  String get currentFilterQuery => (_filterSubject.value as _CardFilter).text;

  void filterCards(String query) {
    _filterSubject.add(_CardFilter(text: query));
  }
}

extension _SortWordList<T extends Word> on List<T> {
  List<T> sortByWord() {
    this.sort((T o1, T o2) {
      String s1 = o1.word.toLowerCase();
      String s2 = o2.word.toLowerCase();

      return s1.compareTo(s2);
    });
    return this;
  }
}
