import 'package:flashcard/converter/grammatical_number_converter.dart';
import 'package:flashcard/converter/noun_form_type_converters.dart';
import 'package:flashcard/model/noun.dart';
import 'package:flashcard/storage/store_object.dart';
import 'package:get_it/get_it.dart';

class NounFormToObjectConverter {
  final NounFormTypeToStringConverter _nounFormConverter;
  final GrammaticalNumberToStringConverter _numberConverter;

  NounFormToObjectConverter(
      {NounFormToObjectConverter nounFormConverter,
      GrammaticalNumberToStringConverter numberConverter})
      : _nounFormConverter = nounFormConverter ?? GetIt.I.get(),
        _numberConverter = numberConverter ?? GetIt.I.get();

  StoreObject convert(NounForm form) => StoreObject(fields: {
        "type": _nounFormConverter.convert(form.type),
        "number": _numberConverter.convert(form.number),
        "article": form.article,
        "word": form.word,
      }, subcollections: null);
}
