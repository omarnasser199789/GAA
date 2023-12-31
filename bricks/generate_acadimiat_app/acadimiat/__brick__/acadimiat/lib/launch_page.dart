import 'dart:developer';

import 'package:acadmiat/splash_screen.dart';
import 'package:acadmiat/Theme/theme_notifier.dart';
import 'package:acadmiat/test/consumable_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart'  as flutter_localizations;


import 'Locale/language_cubit.dart';
import 'Locale/locale.dart';
import 'Theme/style.dart';
import 'Theme/theme_values.dart';
import 'core/globals.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:signalr_core/signalr_core.dart';
import 'dart:io';
import 'package:http/io_client.dart';

import 'package:showcaseview/showcaseview.dart';


HubConnection connection = HubConnectionBuilder()
    .withUrl(
    baseSignalRUrl,
    HttpConnectionOptions(
      accessTokenFactory: () async
      =>
      globalSH.getString(CACHED_JWT_TOKEN),

      transport: HttpTransportType.webSockets,
      client: IOClient(
          HttpClient()..badCertificateCallback = (x, y, z) => true),
      logging: (level, message) => print('HubConnectionState: $level: $message'),
    ))
    .withAutomaticReconnect()
    .build();

class LaunchPage extends StatelessWidget {
  LaunchPage({Key? key}) : super(key: key);

  static final ValueNotifier<ThemeMode> themeNotifier =  ValueNotifier(ThemeMode.system);
  String lan = "";
  @override
  void initState() {_firebaseCrash();}

  void _firebaseCrash()async{
    if (kDebugMode) {
      // Force disable Crashlytics collection while doing every day development.
      // Temporarily toggle this to true if you want to test crash reporting in your app.
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    } else {
      // Handle Crashlytics enabled status when not in Debug,
      // e.g. allow your users to opt-in to crash reporting.
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    }
  }

  @override
  Widget build(BuildContext context) {

    final themeNotifier_ = Provider.of<ThemeNotifier>(context);

    if( globalSH.getString("ThemeMode")==""){
      LaunchPage.themeNotifier.value = ThemeMode.system;
    }else if(globalSH.getString("ThemeMode")=="dark"){
      LaunchPage.themeNotifier.value = ThemeMode.dark;
    }else if(globalSH.getString("ThemeMode")=="light"){
      LaunchPage.themeNotifier.value = ThemeMode.light;
    }

    return BlocProvider<LanguageCubit>(
      create: (context) => LanguageCubit(Locale("ar")),
      child: BlocBuilder<LanguageCubit, Locale>(
          builder: (context, locale) =>
              ValueListenableBuilder<ThemeMode>(
                  valueListenable: themeNotifier,
                  builder: (_, ThemeMode currentMode, __) {
                    SystemChrome.setPreferredOrientations([
                      DeviceOrientation.portraitUp,
                      DeviceOrientation.portraitDown,
                      DeviceOrientation.landscapeLeft,
                      DeviceOrientation.landscapeRight,
                    ]);
                    return MaterialApp(
                      title: 'Mastery Academy',
                      debugShowCheckedModeBanner: false,
                      themeMode: currentMode,
                      builder: (_, child) => Portal(child: child!),
                      theme: themeNotifier_.getTheme(),
                      darkTheme: darkTheme,
                      localizationsDelegates: const [
                        AppLocalizationsDelegate(),
                        flutter_localizations.GlobalMaterialLocalizations.delegate,
                        flutter_localizations.GlobalWidgetsLocalizations.delegate,
                        flutter_localizations.GlobalCupertinoLocalizations.delegate,
                      ],
                     localeListResolutionCallback: (locales, supportedLocales) {
                       if (globalSH.getString(CACHED_USER_LANGUAGE) == null ||
                           globalSH.getString(CACHED_USER_LANGUAGE) == "") {
                         lan = supportedLocales.toString()[1] +
                             supportedLocales.toString()[2];
                         globalSH.setString(CACHED_USER_LANGUAGE, lan);
                       } else {
                         if (globalSH.getString(CACHED_USER_LANGUAGE) == 'ar') {
                           lan = 'ar';

                         } else {
                           lan = 'en';
                         }
                       }
                     },
                      supportedLocales: const [
                        Locale('en'),
                        Locale('ar'),
                        Locale('id'),
                        Locale('fr'),
                        Locale('pt'),
                        Locale('es'),
                        Locale('tk'),
                        Locale('sw'),
                        Locale('it'),
                        Locale('fa'),
                      ],
                      locale: locale,
                      home:  SplashScreen(),
                    );
                  })
      ),
    );
  }


}
