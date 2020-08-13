import 'package:flashcard/converter/verb_form_to_object_converter.dart';
import 'package:flashcard/converter/word_to_map_converter.dart';
import 'package:flashcard/model/verb.dart';
import 'package:flashcard/storage/store_object.dart';
import 'package:get_it/get_it.dart';

class VerbToStoreObjectConverter {
  WordToMapConverter _wordConverter;
  VerbFormToStoreObjectConverter _converter;

  VerbToStoreObjectConverter(
      {WordToMapConverter wordConverter,
      VerbFormToStoreObjectConverter converter})
      : _wordConverter = wordConverter ?? GetIt.I.get(),
        _converter = converter ?? GetIt.I.get();

  StoreObject convert(Verb verb) => StoreObject(id: verb.id, fields: {
        ..._wordConverter.convert(verb),
      }, subcollections: {
        "forms": verb.forms.map((e) => _converter.convert(e)).toList(),
      });
}
