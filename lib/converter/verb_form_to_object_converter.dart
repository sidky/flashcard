import 'package:flashcard/converter/verb_form_type_converters.dart';
import 'package:flashcard/model/verb.dart';
import 'package:flashcard/storage/store_object.dart';
import 'package:get_it/get_it.dart';

class VerbFormToStoreObjectConverter {
  final VerbFormTypeToStringConverter _converter;

  VerbFormToStoreObjectConverter({VerbFormTypeToStringConverter converter})
      : _converter = converter ?? GetIt.I.get();

  StoreObject convert(VerbForm form) => StoreObject(
      id: form.id,
      fields: {
        "type": _converter.convert(form.type),
        "verb": form.verb,
      },
      subcollections: null);
}
