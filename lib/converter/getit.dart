import 'package:flashcard/converter/document_to_noun_converter.dart';
import 'package:flashcard/converter/document_to_noun_form_converter.dart';
import 'package:flashcard/converter/firebase_user_converter.dart';
import 'package:flashcard/converter/grammatical_number_converter.dart';
import 'package:flashcard/converter/noun_form_to_object_converter.dart';
import 'package:flashcard/converter/noun_form_type_converters.dart';
import 'package:flashcard/converter/noun_to_object_converter.dart';
import 'package:flashcard/converter/word_to_map_converter.dart';
import 'package:get_it/get_it.dart';

void setup() {
  GetIt.I.registerLazySingleton<FirebaseUserConverter>(
      () => FirebaseUserConverter());
  GetIt.I.registerLazySingleton<DocumentToNounConverter>(
      () => DocumentToNounConverter());
  GetIt.I.registerLazySingleton<DocumentToNounFormConverter>(
      () => DocumentToNounFormConverter());

  GetIt.I.registerLazySingleton<NounFormTypeToStringConverter>(
      () => NounFormTypeToStringConverter());
  GetIt.I.registerLazySingleton<StringToNounFormTypeConverter>(
      () => StringToNounFormTypeConverter());

  GetIt.I.registerLazySingleton(() => GrammaticalNumberToStringConverter());
  GetIt.I.registerLazySingleton(() => StringToGrammaticalNumberConverter());

  GetIt.I.registerLazySingleton(() => WordToMapConverter());

  GetIt.I.registerLazySingleton(() => NounFormToObjectConverter());
  GetIt.I.registerLazySingleton(() => NounToStoreObjectConverter());
}
