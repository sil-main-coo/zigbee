import 'package:monitor_sensor/bloc/app_bloc/bloc.dart';
import 'package:monitor_sensor/views/home/home_screen.dart';
import 'package:monitor_sensor/views/login/login.dart';
import 'package:monitor_sensor/views/router/router.dart';
import 'package:monitor_sensor/views/splash/splash_screen.dart';
import 'package:monitor_sensor/views/widgets/dialogs/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'configs/values/values.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: ScreenUtilInit(
        designSize: Size(375, 812),
        builder: () => MaterialApp(
          title: 'DT010210 Zigbee',
          initialRoute: '/',
          onGenerateRoute: router(),
          debugShowCheckedModeBanner: false,
          theme: AppTheme.themeDefault,
          builder: (context, child) {
            return MediaQuery(
              ///Setting font does not change with system font size
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!,
            );
          },
          home: BlocConsumer<AppBloc, AppState>(
            listener: (context, state) {
              if (state is AppLoading) {
                LoadingDialog.show(context, '');
              } else if (state is HideAppLoading) {
                LoadingDialog.hide(context);
              }
            },
            builder: (context, state) {
              if (state is AppAuthenticated) {
                return HomeScreen();
              }
              if (state is AppUnauthenticated) {
                return LoginPage();
              }
              return SplashScreen();
            },
          ),
        ),
      ),
    );
  }
}
