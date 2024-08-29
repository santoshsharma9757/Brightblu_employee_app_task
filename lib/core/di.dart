import 'package:brightblu_user_info/repositories/user_repository/user_repository.dart';
import 'package:brightblu_user_info/services/firebase_services/firebase_services.dart';
import 'package:brightblu_user_info/services/firebase_services/i_firebase_services.dart';
import 'package:brightblu_user_info/services/pdf_generations_services/pdf_generation_services.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setupDI() {
  // Register services
  getIt.registerLazySingleton<IFirebaseService>(() => FirebaseService());

  // Register repositories
  getIt.registerLazySingleton<UserRepository>(
      () => UserRepository(getIt<IFirebaseService>()));

  // Register PDF generation service
  getIt.registerLazySingleton<PdfGenerationService>(
      () => PdfGenerationService());
}
