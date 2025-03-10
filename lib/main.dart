import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/mobile/config/global_key.dart' show GlobalVariable;
import 'package:weather_app/mobile/config/size_config.dart';
import 'package:weather_app/mobile/config/theme.dart';
import 'package:weather_app/mobile/constants/constant.dart';
import 'package:weather_app/mobile/modules/home/home_screen.dart';
import 'package:weather_app/mobile/routes/route_generate.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static void setLocal(BuildContext context, Locale locale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(locale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  String language = '';
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },

      // Listener(
      //   onPointerDown: (_) {
      //     FocusScopeNode currentFocus = FocusScope.of(context);
      //     currentFocus.requestFocus();
      //     // if (!currentFocus.hasPrimaryFocus &&
      //     //     currentFocus.focusedChild != null) {
      //     //   FocusManager.instance.primaryFocus?.unfocus();
      //     // }
      //   },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Wheather App',
        theme: theme(),
        locale: _locale,
        // ignore: prefer_const_literals_to_create_immutables
        // localizationsDelegates: [
        //   CustomLocalizations.delegate,
        // ],
        // supportedLocales: const [
        //   Locale('vi', ''),
        //   Locale('en', ''),
        // ],
        color: wPrimaryBgScreenColor,
        home: LayoutBuilder(
          builder: (context, constraints) {
            return OrientationBuilder(
              builder: (context, orientation) {
                SizeConfig().init(constraints, orientation);
                return const HomeScreen();
              },
            );
          },
        ),
        navigatorKey: GlobalVariable.navState,
        routes: routes,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: TextScaler.linear(1.0)),
            child: child ?? Container(),
          );
        },
      ),
    );
  }
}
