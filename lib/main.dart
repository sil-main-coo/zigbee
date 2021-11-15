import 'package:firebase_core/firebase_core.dart';
import 'package:monitor_sensor/app.dart';
import 'package:monitor_sensor/bloc/app_bloc/bloc.dart';
import 'package:monitor_sensor/bloc_delegate.dart';
import 'package:monitor_sensor/provider/helpers/firebase_database_helper.dart';
import 'package:monitor_sensor/provider/singletons/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'configs/values/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // set color status bar and navigationbar
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: secondary, // navigation bar color
      statusBarColor: primary, // status bar color
      statusBarBrightness: Brightness.light));

  setupLocator(); // setup get it : MQTT service
  await locator.get<FirebaseDatabaseHelper>().initial();

  Bloc.observer = SimpleBlocObserver();

  // set only vertical screen
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(BlocProvider<AppBloc>(
        create: (context) => locator<AppBloc>()
          ..add(
            AppStarted(),
          ),
        child: MyApp()));
  });
}
