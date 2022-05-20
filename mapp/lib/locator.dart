import 'package:mapp/core/services/database_service.dart';
import 'package:mapp/core/services/firestoreDB_service.dart';
import 'package:get_it/get_it.dart';
import 'package:mapp/core/services/authentication_service.dart';
import 'package:mapp/core/services/ocrTextExtraction_service.dart';
import 'package:mapp/core/services/questionGeneration_service.dart';
import 'package:mapp/core/viewmodel/homeview_model.dart';
import 'package:mapp/core/viewmodel/loginview_model.dart';
import 'package:mapp/core/viewmodel/questionpage_model.dart';
import 'package:mapp/core/viewmodel/signupview_model.dart';
import 'package:mapp/core/viewmodel/startupview_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory(() => HomeViewModel());
  locator.registerFactory(() => QuestionPageModel());
  locator.registerFactory(() => SignUpViewModel());
  locator.registerFactory(() => LogInViewModel());
  locator.registerFactory(() => StartUpViewModel());

  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => FirestoreService());
  locator.registerLazySingleton(() => DatabaseService());
  locator.registerLazySingleton(() => OcrImplService());
  locator.registerLazySingleton(() => QuestionGenerationService());
}
