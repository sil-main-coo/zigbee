import 'package:monitor_sensor/bloc/app_bloc/app_bloc.dart';
import 'package:monitor_sensor/provider/helpers/firebase_database_helper.dart';
import 'package:monitor_sensor/provider/local/authen_local_provider.dart';

import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory<AuthenLocalProvider>(() => AuthenLocalProvider());

  locator.registerLazySingleton<AppBloc>(() => AppBloc(locator()));

  locator.registerLazySingleton<FirebaseDatabaseHelper>(
      () => FirebaseDatabaseHelper());
}
