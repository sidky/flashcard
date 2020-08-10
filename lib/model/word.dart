class Word {
  final String id;
  final String word;
  final String translation;
  final DateTime createdAt;
  final DateTime updatedAt;

  Word(this.id, this.word, this.translation, this.createdAt, this.updatedAt);

  Map<String, dynamic> toJson() => {
        "id": id,
        "word": word,
        "translation": translation,
        "createdAt": createdAt,
        "updatedAt": updatedAt
      };
}
