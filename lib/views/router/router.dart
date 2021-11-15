
import 'package:monitor_sensor/configs/values/colors.dart';
import 'package:flutter/material.dart';

RouteFactory router() {
  return (RouteSettings settings) {
    Widget screen;

    var args = settings.arguments as Map<String, dynamic>;

    switch (settings.name) {
      // case RouteName.home:
      //   return MaterialPageRoute(
      //     builder: (context) => BlocProvider.value(
      //       value: BlocProvider.of<ClassroomsBloc>(context)..add(FetchClassrooms()),
      //       child: InitHome(),
      //     ),
      //   );
      default:
        screen = FailedRouteWidget(settings.name!);
        return MaterialPageRoute(
          builder: (_) => screen,
        );
    }
  };
}

class FailedRouteWidget extends StatelessWidget {
  FailedRouteWidget(this._name);

  final String _name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lạc đường rồi'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.sentiment_neutral,
                size: 32,
                color: secondary,
              ),
              Text('Có vẻ bạn đã bị lạc đường $_name'),
            ],
          ),
        ),
      ),
    );
  }
}
