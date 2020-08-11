class Word {
  final String id;
  final String word;
  final String translation;

  Word(this.id, this.word, this.translation);

  Map<String, dynamic> toJson() =>
      {"id": id, "word": word, "translation": translation};
}
