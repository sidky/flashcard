import 'package:flashcard/converter/noun_form_to_object_converter.dart';
import 'package:flashcard/converter/word_to_map_converter.dart';
import 'package:flashcard/model/noun.dart';
import 'package:flashcard/storage/store_object.dart';
import 'package:get_it/get_it.dart';

class NounToStoreObjectConverter {
  final WordToMapConverter _wordConverter;
  final NounFormToObjectConverter _converter;

  NounToStoreObjectConverter(
      {WordToMapConverter wordConverter, NounFormToObjectConverter converter})
      : _wordConverter = wordConverter ?? GetIt.I.get(),
        _converter = converter ?? GetIt.I.get();

  StoreObject convert(Noun noun) => StoreObject(
          id: noun.id,
          fields: _wordConverter.convert(noun),
          subcollections: {
            "forms": noun.forms.map((e) => _converter.convert(e)).toList()
          });
}
