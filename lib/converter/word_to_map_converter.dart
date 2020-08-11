import 'package:flashcard/model/word.dart';

class WordToMapConverter {
  Map<String, dynamic> convert(Word word) => {
        "word": word.word,
        "translation": word.translation,
      };
}
